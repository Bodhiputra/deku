#!/usr/bin/env python3
"""Emit hook JSON for Cursor or Codex from shared Deku hook scripts."""
from __future__ import annotations

import json
import os
import sys


def load_input() -> dict:
    env_raw = os.environ.get("HOOK_JSON", "").strip()
    if env_raw:
        try:
            return json.loads(env_raw)
        except json.JSONDecodeError:
            pass
    raw = sys.stdin.read()
    if not raw.strip():
        return {}
    try:
        return json.loads(raw)
    except json.JSONDecodeError:
        return {}


def is_codex(data: dict) -> bool:
    return bool(data.get("hook_event_name"))


def emit_json(payload: dict) -> None:
    print(json.dumps(payload))


def emit_agent_message(data: dict, message: str) -> None:
    if is_codex(data):
        event = data.get("hook_event_name") or "UserPromptSubmit"
        emit_json(
            {
                "hookSpecificOutput": {
                    "hookEventName": event,
                    "additionalContext": message,
                }
            }
        )
    else:
        emit_json({"agent_message": message})


def emit_followup(data: dict, message: str) -> None:
    if is_codex(data):
        emit_json(
            {
                "hookSpecificOutput": {
                    "hookEventName": data.get("hook_event_name") or "Stop",
                    "additionalContext": message,
                }
            }
        )
    else:
        emit_json({"followup_message": message})


def emit_deny(data: dict, message: str) -> None:
    if is_codex(data):
        emit_json(
            {
                "hookSpecificOutput": {
                    "hookEventName": data.get("hook_event_name") or "PreToolUse",
                    "permissionDecision": "deny",
                    "permissionDecisionReason": message,
                }
            }
        )
    else:
        emit_json(
            {
                "permission": "deny",
                "user_message": message,
                "agent_message": message,
            }
        )


def emit_allow() -> None:
    emit_json({"permission": "allow"})
