---
name: run-research
description: Triggers a full marketing research cycle including content intelligence.
  Jinu loads session context, confirms brand and product understanding, and runs
  all mission agents in sequence. Use when you want a complete research run.
---

# Run Full Research Cycle

When this skill is invoked:
1. Invoke Jinu as a BACKGROUND agent (run_in_background: true) — always, no exceptions
2. Jinu runs `date` to confirm today's date
3. Jinu reads context/session-context.md
4. Jinu confirms brand and product context to user in 2-3 sentences
5. Jinu runs agents in this exact sequence:
   a. Industry Scout
   b. Competitor Intel Agent
   c. Buyer Persona Agent
   d. Pain Point Miner
   e. Market Sizing Agent (TAM/SAM/SOM — after a through d are approved)
   f. Content Intel Agent (receives Buyer Persona + Competitor Intel context)
   g. Positioning Analyst (after a through f are approved)
   h. Content Strategist Agent (receives all above findings)
6. Jinu evaluates each output — re-runs specific agents if insufficient
7. Jinu hands full approved package to Notion Knowledge Manager
8. Jinu delivers executive summary to user when complete

IMPORTANT: The full pipeline must run entirely in the background. The user should
not need to monitor or interact with anything during the run. Claude Code informs
the user that research has started and will notify them when done.
