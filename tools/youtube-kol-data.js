#!/usr/bin/env node
// YouTube KOL Data Collector
// Usage: node tools/youtube-kol-data.js @Handle1 @Handle2 ...
// Reads YOUTUBE_API_KEY from .env at project root
// Output: JSON array of KOL data cards (stdout). Progress to stderr.

const { readFileSync, existsSync } = require('fs');
const { join } = require('path');

// Load .env
const envPath = join(__dirname, '..', '.env');
if (existsSync(envPath)) {
  readFileSync(envPath, 'utf8').split('\n').forEach(line => {
    const eq = line.indexOf('=');
    if (eq > 0) process.env[line.slice(0, eq).trim()] = line.slice(eq + 1).trim();
  });
}

const KEY = process.env.YOUTUBE_API_KEY;
if (!KEY) { console.error('YOUTUBE_API_KEY not found in .env'); process.exit(1); }

const BASE = 'https://www.googleapis.com/youtube/v3';

async function get(endpoint, params) {
  const url = `${BASE}/${endpoint}?${new URLSearchParams({ ...params, key: KEY })}`;
  const res = await fetch(url);
  const data = await res.json();
  if (data.error) throw new Error(`YouTube API error: ${data.error.message}`);
  return data;
}

async function collectKOL(handle) {
  const h = handle.replace(/^@/, '');
  process.stderr.write(`\nCollecting: @${h}\n`);

  // Step 1 — Channel ID, subscriber count, country, uploads playlist ID
  const ch = await get('channels', {
    part: 'statistics,snippet,contentDetails',
    forHandle: h
  });

  if (!ch.items?.length) return { handle: `@${h}`, error: 'Channel not found' };

  const channel     = ch.items[0];
  const channelId   = channel.id;
  const subscribers = parseInt(channel.statistics.subscriberCount || 0);
  const country     = channel.snippet.country || 'Not set in channel';
  const uploadsId   = channel.contentDetails.relatedPlaylists.uploads;

  process.stderr.write(`  Subscribers: ${subscribers.toLocaleString()} | Country: ${country}\n`);

  // Step 2 — Last 15 video IDs from uploads playlist
  const pl = await get('playlistItems', {
    part: 'contentDetails',
    playlistId: uploadsId,
    maxResults: 15
  });
  const videoIds = pl.items.map(i => i.contentDetails.videoId);

  // Step 3 — Stats + published date for all videos in one call
  const vids = await get('videos', {
    part: 'statistics,snippet,contentDetails',
    id: videoIds.join(',')
  });

  // Filter to last 12 months, cap at 10
  const cutoff = new Date();
  cutoff.setFullYear(cutoff.getFullYear() - 1);

  const qualifying = vids.items
    .filter(v => new Date(v.snippet.publishedAt) >= cutoff)
    .slice(0, 10);

  if (!qualifying.length) return { handle: `@${h}`, error: 'No videos published in last 12 months' };

  let totalViews = 0, totalLikes = 0, totalComments = 0;
  const videos = qualifying.map(v => {
    const views    = parseInt(v.statistics.viewCount    || 0);
    const likes    = parseInt(v.statistics.likeCount    || 0);
    const comments = parseInt(v.statistics.commentCount || 0);
    totalViews    += views;
    totalLikes    += likes;
    totalComments += comments;
    return {
      id: v.id,
      title: v.snippet.title,
      published: v.snippet.publishedAt.slice(0, 10),
      duration: v.contentDetails.duration,
      views, likes, comments
    };
  });

  const n           = qualifying.length;
  const avgViews    = Math.round(totalViews    / n);
  const avgLikes    = Math.round(totalLikes    / n);
  const avgComments = Math.round(totalComments / n);
  const er          = +((totalLikes + totalComments) / totalViews * 100).toFixed(2);

  process.stderr.write(`  Videos: ${n} | ER: ${er}% | Avg Views: ${avgViews.toLocaleString()}\n`);

  // Step 4 — Top 50 comments from highest-viewed qualifying video (C3 purchase-intent check)
  const topVideo = [...videos].sort((a, b) => b.views - a.views)[0];
  let c3Comments = [];
  try {
    const ct = await get('commentThreads', {
      part: 'snippet',
      videoId: topVideo.id,
      maxResults: 50,
      order: 'relevance'
    });
    c3Comments = ct.items?.map(c => c.snippet.topLevelComment.snippet.textDisplay) || [];
  } catch {
    c3Comments = ['Comments disabled or unavailable on this video'];
  }

  return {
    handle: `@${h}`,
    channelUrl: `https://www.youtube.com/@${h}`,
    channelId,
    subscribers,
    country,
    er,
    erPass: er >= 1,
    avgViews,
    avgLikes,
    avgComments,
    videosAnalysed: n,
    videos,
    c3SampleVideo: topVideo.title,
    c3Comments
  };
}

async function main() {
  const handles = process.argv.slice(2);
  if (!handles.length) {
    console.log('Usage: node tools/youtube-kol-data.js @Handle1 @Handle2 ...');
    process.exit(0);
  }

  const results = [];
  for (const h of handles) {
    results.push(await collectKOL(h));
  }

  console.log(JSON.stringify(results, null, 2));
}

main().catch(err => { console.error(err.message); process.exit(1); });
