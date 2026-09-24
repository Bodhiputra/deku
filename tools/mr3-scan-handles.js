#!/usr/bin/env node
// Scan channel upload playlists for Edifier MR3 mentions (max 200 videos)
// Usage: node tools/mr3-scan-handles.js handle1 handle2 ...

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

const handles = process.argv.slice(2).map(h => h.replace(/^@/, ''));
if (!handles.length) { console.error('Pass handles'); process.exit(1); }

async function get(endpoint, params) {
  const url = `https://www.googleapis.com/youtube/v3/${endpoint}?${new URLSearchParams({ ...params, key: KEY })}`;
  const res = await fetch(url);
  const data = await res.json();
  if (data.error) throw new Error(data.error.message);
  return data;
}

async function scan(h) {
  const ch = await get('channels', { part: 'contentDetails,statistics,snippet', forHandle: h });
  const item = ch.items?.[0];
  if (!item) return { handle: '@' + h, error: 'not found' };

  const country = item.snippet.country || '?';
  if (country !== 'US' && country !== '?') return null;

  let token = '';
  let checked = 0;
  let hit = null;

  do {
    const params = {
      part: 'snippet',
      playlistId: item.contentDetails.relatedPlaylists.uploads,
      maxResults: 50,
    };
    if (token) params.pageToken = token;
    const pl = await get('playlistItems', params);
    for (const it of pl.items || []) {
      checked++;
      if (/\bmr3\b|edifier mr3/i.test(it.snippet.title)) {
        hit = {
          name: item.snippet.title,
          handle: '@' + ((item.snippet.customUrl || '').replace('@', '') || h),
          subs: parseInt(item.statistics.subscriberCount || 0),
          country,
          videoTitle: it.snippet.title,
          url: 'https://youtube.com/watch?v=' + it.snippet.resourceId.videoId,
          checked,
        };
        break;
      }
    }
    token = pl.nextPageToken || '';
  } while (token && !hit && checked < 200);

  return hit;
}

(async () => {
  const found = [];
  for (const h of handles) {
    process.stderr.write('.');
    const r = await scan(h);
    if (r) found.push(r);
  }
  found.sort((a, b) => b.subs - a.subs);
  console.log(JSON.stringify(found, null, 2));
  console.error('\nCOUNT', found.length);
})();
