#!/usr/bin/env node
// KOL Exclusion List Sync
// Fetches ALL records from Notion KOL Pools DB (paginated) and writes context/kol-exclusion-list.md
//
// Usage:
//   node tools/sync-kol-list.js                 — full sync
//   node tools/sync-kol-list.js --add @handle     — append a single handle without re-fetching
//   node tools/sync-kol-list.js --check @handle   — exit 0 if NOT in pool; exit 1 if exists (live Notion)
//   node tools/sync-kol-list.js --check @handle --file-only  — check kol-exclusion-list.md only (no API)
//
// NOTION_API_KEY loaded from: .env → .claude/settings.local.json (fallback)

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

function loadDatabaseId() {
  if (process.env.NOTION_KOL_DATABASE_ID) {
    return process.env.NOTION_KOL_DATABASE_ID.trim();
  }
  const brandPath = join(ROOT, 'context', 'brand-context.md');
  if (existsSync(brandPath)) {
    const content = readFileSync(brandPath, 'utf8');
    const m = content.match(/\*\*KOL Pools database ID:\*\*\s*([a-f0-9-]+)/i);
    if (m) return m[1].trim();
  }
  console.error(
    'KOL database ID not found. Set NOTION_KOL_DATABASE_ID in .env or add\n' +
    '  **KOL Pools database ID:** <uuid>\n' +
    'to context/brand-context.md under Documentation.'
  );
  process.exit(1);
}

const NOTION_KEY = process.env.NOTION_API_KEY;
if (!NOTION_KEY) {
  console.error('NOTION_API_KEY not found. Add to .env (see .env.example).');
  process.exit(1);
}

const DB_ID = loadDatabaseId();

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

async function queryByHandle(handle) {
  const variants = [...new Set([
    handle,
    handle.startsWith('@') ? handle.slice(1) : `@${handle}`,
  ].map(h => h.trim()).filter(Boolean))];

  const filters = variants.map(v => ({
    property: 'KOL Channel Name',
    title: { equals: v },
  }));

  const res = await fetch(`https://api.notion.com/v1/databases/${DB_ID}/query`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${NOTION_KEY}`,
      'Notion-Version': '2022-06-28',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      page_size: 5,
      filter: filters.length === 1 ? filters[0] : { or: filters },
    }),
  });

  if (!res.ok) throw new Error(`Notion API ${res.status}: ${await res.text()}`);
  const data = await res.json();
  return data.results || [];
}

function checkFileOnly(handle) {
  const outPath = join(ROOT, 'context', 'kol-exclusion-list.md');
  if (!existsSync(outPath)) return false;
  const key = handleKey(handle);
  const content = readFileSync(outPath, 'utf8');
  const re = new RegExp(`^-\\s@?${key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\s*$`, 'im');
  return re.test(content);
}

async function checkHandle(handle, { fileOnly = false } = {}) {
  const normalized = handle.startsWith('@') ? handle : `@${handle}`;
  if (fileOnly && checkFileOnly(normalized)) {
    return { exists: true, source: 'kol-exclusion-list.md' };
  }
  if (fileOnly) {
    return { exists: false, source: 'kol-exclusion-list.md' };
  }
  const hits = await queryByHandle(normalized);
  if (hits.length) {
    return {
      exists: true,
      source: 'notion',
      count: hits.length,
      ids: hits.map(p => p.id),
    };
  }
  return { exists: false, source: 'notion' };
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

// ── Duplicate detection & dedupe ─────────────────────────────────────────────
const TAG_RANK = { Qualified: 4, Stored: 3, 'Need Confirmation': 2, '': 1, Unqualified: 0 };

function handleKey(name) {
  return (name || '').replace(/^@/, '').toLowerCase().trim();
}

function recordScore(r) {
  let s = (TAG_RANK[r.tags] ?? 1) * 1000;
  if (r.name.startsWith('@')) s += 50;
  return s;
}

function dedupeRecords(records) {
  const byKey = new Map();
  for (const r of records) {
    const key = handleKey(r.name);
    if (!key) continue;
    const prev = byKey.get(key);
    if (!prev || recordScore(r) > recordScore(prev)) byKey.set(key, r);
  }
  return [...byKey.values()];
}

function findDuplicates(records) {
  const seen = {};
  const dupes = [];
  for (const r of records) {
    const key = handleKey(r.name);
    if (!key) continue;
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
  const unique = dedupeRecords(records);
  const sorted = [...unique].sort((a, b) =>
    handleKey(a.name).localeCompare(handleKey(b.name), undefined, { sensitivity: 'base' })
  );

  const lines = [
    '# KOL Exclusion List',
    `*Auto-generated from Notion KOL Pools DB — ${records.length} records (${unique.length} unique handles) — last synced: ${date}*`,
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

  lines.push(section('By Country', group(unique, 'country')));
  lines.push(section('By Platform', group(unique, 'platform')));
  lines.push(section('By Tier', group(unique, 'tier'), [...TIER_ORDER, 'Unknown']));

  // Tags (Qualified / Stored / Unqualified) + Status (Not started / In Contact / Deal)
  lines.push('## By Tags');
  lines.push('');
  const byTag = group(unique, 'tags');
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
  const byStatus = group(unique, 'status');
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

  if (args[0] === '--check' && args[1]) {
    const fileOnly = args.includes('--file-only');
    const result = await checkHandle(args[1], { fileOnly });
    if (result.exists) {
      const where = result.source === 'notion'
        ? `Notion KOL Pools (${result.count} record${result.count === 1 ? '' : 's'})`
        : result.source;
      console.error(`BLOCKED: ${args[1]} already in ${where}. Skip write or update existing record.`);
      if (result.ids?.length) {
        result.ids.forEach(id => console.error(`  → https://www.notion.so/${id.replace(/-/g, '')}`));
      }
      process.exit(1);
    }
    console.log(`OK: ${args[1]} not in KOL Pools — safe to write.`);
    return;
  }

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
