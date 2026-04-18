---
name: feedback_autonomous_execution
description: Once a heavy task is underway, execute all phases autonomously without check-ins; report only when done
type: feedback
---

Once a pipeline run or heavy multi-phase task is underway, execute all phases to completion without mid-run check-ins. Report only when the full task is done.

**Why:** The user's standard is zero mid-run human involvement. Check-ins break flow, interrupt the user's attention, and undermine the autonomous-run model.

**How to apply:** Handle all decisions, failures, and course corrections internally (documented in session-context.md). The only exception is a critical infrastructure failure (Notion MCP down, browser tool unavailable) that cannot be worked around.
