#!/usr/bin/env node
// Verify YouTube video IDs → channel country/subs for MR3 discovery
// Usage: node tools/mr3-verify-videos.js VIDEO_ID1 VIDEO_ID2 ...

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

async function get(endpoint, params) {
  const url = `https://www.googleapis.com/youtube/v3/${endpoint}?${new URLSearchParams({ ...params, key: KEY })}`;
  const res = await fetch(url);
  const data = await res.json();
  if (data.error) throw new Error(data.error.message);
  return data;
}

(async () => {
  const videos = await get('videos', { part: 'snippet', id: ids.join(',') });
  const chIds = [...new Set(videos.items.map(v => v.snippet.channelId))];
  const channels = await get('channels', { part: 'snippet,statistics', id: chIds.join(',') });
  const chMap = Object.fromEntries(channels.items.map(c => [c.id, c]));
  const byHandle = new Map();

  for (const v of videos.items) {
    const ch = chMap[v.snippet.channelId];
    const handle = (ch.snippet.customUrl || '').replace('@', '').toLowerCase() || ch.id;
    if (!/\bmr3\b|edifier mr3/i.test(v.snippet.title)) continue;
    const row = {
      name: ch.snippet.title,
      handle: '@' + ((ch.snippet.customUrl || '').replace('@', '') || handle),
      subs: parseInt(ch.statistics.subscriberCount || 0),
      country: ch.snippet.country || '?',
      videoTitle: v.snippet.title,
      url: 'https://youtube.com/watch?v=' + v.id,
    };
    if (!byHandle.has(handle)) byHandle.set(handle, row);
  }

  const all = [...byHandle.values()].sort((a, b) => b.subs - a.subs);
  console.log(JSON.stringify({
    us: all.filter(r => r.country === 'US'),
    unset: all.filter(r => r.country === '?'),
    other: all.filter(r => r.country !== 'US' && r.country !== '?'),
  }, null, 2));
})();
