---
name: update-notion
description: Triggers Notion Knowledge Manager to document pending approved findings.
  Use to push findings to Notion manually or retry a failed documentation run.
---

# Update Notion

When this skill is invoked:
1. Invoke Notion Knowledge Manager
2. Notion Manager checks output/notion-drafts/ for pending approved findings
3. Documents all pending findings to Notion using the full workspace structure
4. Reports back: what was added, which databases were updated
