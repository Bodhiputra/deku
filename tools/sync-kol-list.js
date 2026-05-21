#!/usr/bin/env node
// KOL Exclusion List Sync
// Fetches ALL records from Notion KOL Pools DB (paginated) and writes context/kol-exclusion-list.md
//
// Usage:
//   node tools/sync-kol-list.js          — full sync
//   node tools/sync-kol-list.js --add @handle   — append a single handle without re-fetching
//
// NOTION_API_KEY loaded from: process.env → .env → .claude/settings.local.json

const { readFileSync, existsSync, writeFileSync } = require('fs');
const { join } = require('path');

const ROOT = join(__dirname, '..');

// ── Env loading ──────────────────────────────────────────────────────────────
function loadEnv() {
  const envPath = join(ROOT, '.env');
  if (existsSync(envPath)) {
    readFileSync(envPath, 'utf8').split('\n').forEach(line => {
      const eq = line.indexOf('=');
      if (eq > 0 && !process.env[line.slice(0, eq).trim()])
        process.env[line.slice(0, eq).trim()] = line.slice(eq + 1).trim();
    });
  }
  if (!process.env.NOTION_API_KEY) {
    const settingsPath = join(ROOT, '.claude', 'settings.local.json');
    if (existsSync(settingsPath)) {
      try {
        const s = JSON.parse(readFileSync(settingsPath, 'utf8'));
        if (s?.env?.NOTION_API_KEY) process.env.NOTION_API_KEY = s.env.NOTION_API_KEY;
      } catch {}
    }
  }
}

loadEnv();

const NOTION_KEY = process.env.NOTION_API_KEY;
if (!NOTION_KEY) {
  console.error('NOTION_API_KEY not found. Add to .env or .claude/settings.local.json.');
  process.exit(1);
}

const DB_ID = '34a38ff7-8ba4-80ef-8443-cb6cf60b9c3c';

// ── Notion API ───────────────────────────────────────────────────────────────
async function queryPage(cursor) {
  const body = { page_size: 100 };
  if (cursor) body.start_cursor = cursor;

  const res = await fetch(`https://api.notion.com/v1/databases/${DB_ID}/query`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${NOTION_KEY}`,
      'Notion-Version': '2022-06-28',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body),
  });

  if (!res.ok) throw new Error(`Notion API ${res.status}: ${await res.text()}`);
  return res.json();
}

function prop(page, name, type) {
  const p = page.properties[name];
  if (!p) return null;
  if (type === 'title') return p.title?.map(t => t.plain_text).join('').trim() || null;
  if (type === 'select') return p.select?.name || null;
  if (type === 'status') return p.status?.name || null;
  return null;
}

async function fetchAll() {
  const records = [];
  let cursor = null;
  let page = 1;

  do {
    process.stderr.write(`Fetching page ${page}...\n`);
    const data = await queryPage(cursor);

    for (const p of data.results) {
      const name = prop(p, 'KOL Channel Name', 'title');
      if (!name) continue;
      records.push({
        name,
        country:  prop(p, 'Country',      'select'),
        platform: prop(p, 'Main Platform', 'select'),
        tier:     prop(p, 'KOL Category',  'select'),
        status:   prop(p, 'Status',        'status'),
        tags:     prop(p, 'Tags',          'select'),
      });
    }

    cursor = data.has_more ? data.next_cursor : null;
    page++;
  } while (cursor);

  return records;
}

// ── Duplicate detection ──────────────────────────────────────────────────────
function findDuplicates(records) {
  const seen = {};
  const dupes = [];
  for (const r of records) {
    const key = r.name.replace(/^@/, '').toLowerCase();
    seen[key] = (seen[key] || 0) + 1;
    if (seen[key] === 2) dupes.push(r.name);
  }
  return dupes;
}

// ── Markdown builder ─────────────────────────────────────────────────────────
const TIER_ORDER = [
  'Nano (<10K)', 'Micro(10K-100K)', 'Mid-Tier(100K-500K)',
  'Macro(500K-1M)', 'Mega(>1M)',
];

function group(records, key) {
  return records.reduce((acc, r) => {
    const k = r[key] || 'Unknown';
    (acc[k] = acc[k] || []).push(r.name);
    return acc;
  }, {});
}

function section(title, map, order) {
  const lines = [`## ${title}`, ''];
  const keys = order ? order.filter(k => map[k]) : Object.keys(map).sort();
  const unknown = map['Unknown'];
  for (const k of keys) {
    lines.push(`### ${k} (${map[k].length})`);
    map[k].sort().forEach(n => lines.push(`- ${n}`));
    lines.push('');
  }
  if (!order && unknown) {
    lines.push(`### Unknown (${unknown.length})`);
    unknown.sort().forEach(n => lines.push(`- ${n}`));
    lines.push('');
  }
  lines.push('---', '');
  return lines.join('\n');
}

function buildMarkdown(records, date) {
  const dupes = findDuplicates(records);
  const sorted = [...records].sort((a, b) =>
    a.name.replace(/^@/, '').localeCompare(b.name.replace(/^@/, ''), undefined, { sensitivity: 'base' })
  );

  const lines = [
    '# KOL Exclusion List',
    `*Auto-generated from Notion KOL Pools DB — ${records.length} records — last synced: ${date}*`,
    `*Refresh: \`node tools/sync-kol-list.js\` at the start of every KOL session.*`,
    '',
    '> **Dedup rule:** Before researching or writing any candidate, check the flat list below.',
    '> If the handle is here — skip immediately. After each Notion write, re-run this script.',
    '',
  ];

  if (dupes.length) {
    lines.push('## ⚠ Duplicates Detected');
    lines.push('*These handles appear more than once in Notion — clean up required:*');
    lines.push('');
    dupes.forEach(d => lines.push(`- ${d}`));
    lines.push('');
    lines.push('---');
    lines.push('');
  }

  lines.push('## All Handles (Dedup Reference)');
  lines.push('');
  sorted.forEach(r => lines.push(`- ${r.name}`));
  lines.push('');
  lines.push('---');
  lines.push('');

  lines.push(section('By Country', group(records, 'country')));
  lines.push(section('By Platform', group(records, 'platform')));
  lines.push(section('By Tier', group(records, 'tier'), [...TIER_ORDER, 'Unknown']));

  // Tags (Qualified / Stored / Unqualified) + Status (Not started / In Contact / Deal)
  lines.push('## By Tags');
  lines.push('');
  const byTag = group(records, 'tags');
  const tagOrder = ['Qualified', 'Stored', 'Unqualified', 'Unknown'];
  for (const t of tagOrder.filter(k => byTag[k])) {
    lines.push(`### ${t} (${byTag[t].length})`);
    byTag[t].sort().forEach(n => lines.push(`- ${n}`));
    lines.push('');
  }
  lines.push('---');
  lines.push('');

  lines.push('## By Outreach Status');
  lines.push('');
  const byStatus = group(records, 'status');
  const statusOrder = ['Deal', 'In Contact', 'Not started', 'Unknown'];
  for (const s of statusOrder.filter(k => byStatus[k])) {
    lines.push(`### ${s} (${byStatus[s].length})`);
    byStatus[s].sort().forEach(n => lines.push(`- ${n}`));
    lines.push('');
  }

  return lines.join('\n');
}

// ── --add mode: append a handle to existing file without re-fetching ─────────
function quickAdd(handle) {
  const outPath = join(ROOT, 'context', 'kol-exclusion-list.md');
  if (!existsSync(outPath)) {
    console.error('kol-exclusion-list.md not found — run without --add first to do a full sync.');
    process.exit(1);
  }
  let content = readFileSync(outPath, 'utf8');
  const h = handle.startsWith('@') ? handle : `@${handle}`;
  if (content.includes(`\n- ${h}\n`) || content.includes(`\n- ${h.replace(/^@/, '')}\n`)) {
    console.log(`${h} already in list — no change.`);
    return;
  }
  // Insert into the flat list section (alphabetically would require a re-sort; just append to end of flat list)
  content = content.replace(/(## All Handles[\s\S]*?)(---)/m, (_, block, sep) => `${block}- ${h}\n${sep}`);
  writeFileSync(outPath, content, 'utf8');
  console.log(`Added ${h} to kol-exclusion-list.md`);
}

// ── Main ─────────────────────────────────────────────────────────────────────
async function main() {
  const args = process.argv.slice(2);

  if (args[0] === '--add' && args[1]) {
    quickAdd(args[1]);
    return;
  }

  const records = await fetchAll();
  process.stderr.write(`\nTotal records: ${records.length}\n`);

  const date = new Date().toISOString().slice(0, 10);
  const md = buildMarkdown(records, date);

  const outPath = join(ROOT, 'context', 'kol-exclusion-list.md');
  writeFileSync(outPath, md, 'utf8');

  const dupes = findDuplicates(records);
  if (dupes.length) {
    process.stderr.write(`\n⚠ Duplicates found: ${dupes.join(', ')}\n`);
  }

  console.log(`Synced ${records.length} records → context/kol-exclusion-list.md`);
}

main().catch(err => { console.error(err.message); process.exit(1); });
