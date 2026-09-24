#!/usr/bin/env node
// Verify YouTube video IDs → channel country/subs for product review discovery
// Usage: node tools/product-review-verify.js VIDEO_ID1 VIDEO_ID2 ...
// Filters titles matching ES20, ES60, JBL Go, or SoundLink Micro

const { readFileSync, existsSync } = require('fs');
const { join } = require('path');

const envPath = join(__dirname, '..', '.env');
if (existsSync(envPath)) {
  readFileSync(envPath, 'utf8').split('\n').forEach(line => {
    const eq = line.indexOf('=');
    if (eq > 0) process.env[line.slice(0, eq).trim()] = line.slice(eq + 1).trim();
  });
}

const KEY = process.env.YOUTUBE_API_KEY;
if (!KEY) { console.error('YOUTUBE_API_KEY not found'); process.exit(1); }

const ids = process.argv.slice(2);
if (!ids.length) { console.error('Pass video IDs'); process.exit(1); }

const PRODUCT_RE = /\b(es20|es60|jbl go|soundlink micro)\b/i;
const EXCLUDE = new Set([
  'jbl', 'jblaudio', 'bose', 'edifiernorthamerica', 'edifierglobal', 'edifier_online',
  'jblindia', 'boseindia', 'edifier_malaysia', 'jblaudioeurope',
  'abtelectronics', 'boseproductsupport', 'listenupvideo', 'audioadvice',
]);

async function get(endpoint, params) {
  const url = `https://www.googleapis.com/youtube/v3/${endpoint}?${new URLSearchParams({ ...params, key: KEY })}`;
  const res = await fetch(url);
  const data = await res.json();
  if (data.error) throw new Error(data.error.message);
  return data;
}

function productTag(title) {
  const t = title.toLowerCase();
  if (/\bes20\b/.test(t)) return 'Edifier ES20';
  if (/\bes60\b/.test(t)) return 'Edifier ES60';
  if (/soundlink micro/.test(t)) return 'Bose SoundLink Micro';
  if (/jbl go/.test(t)) return 'JBL Go';
  return 'Other';
}

async function batchGet(endpoint, part, idList) {
  const out = [];
  for (let i = 0; i < idList.length; i += 50) {
    const chunk = idList.slice(i, i + 50);
    const data = await get(endpoint, { part, id: chunk.join(',') });
    out.push(...(data.items || []));
  }
  return out;
}

(async () => {
  const videos = await batchGet('videos', 'snippet', ids);
  const chIds = [...new Set(videos.map(v => v.snippet.channelId))];
  const channels = await batchGet('channels', 'snippet,statistics', chIds);
  const chMap = Object.fromEntries(channels.map(c => [c.id, c]));
  const byHandle = new Map();

  for (const v of videos) {
    if (!PRODUCT_RE.test(v.snippet.title)) continue;
    const ch = chMap[v.snippet.channelId];
    const handle = (ch.snippet.customUrl || '').replace('@', '').toLowerCase() || ch.id;
    if (EXCLUDE.has(handle)) continue;
    const row = {
      name: ch.snippet.title,
      handle: '@' + ((ch.snippet.customUrl || '').replace('@', '') || handle),
      subs: parseInt(ch.statistics.subscriberCount || 0),
      country: ch.snippet.country || '?',
      product: productTag(v.snippet.title),
      videoTitle: v.snippet.title,
      url: 'https://youtube.com/watch?v=' + v.id,
    };
    const prev = byHandle.get(handle);
    if (!prev || row.subs > prev.subs) byHandle.set(handle, row);
  }

  const all = [...byHandle.values()].sort((a, b) => b.subs - a.subs);
  console.log(JSON.stringify({
    total: all.length,
    us: all.filter(r => r.country === 'US'),
    unset: all.filter(r => r.country === '?'),
    other: all.filter(r => r.country !== 'US' && r.country !== '?'),
  }, null, 2));
})();
