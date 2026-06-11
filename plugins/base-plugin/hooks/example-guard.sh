#!/bin/bash
# example-guard.sh - PreToolUse hook for Bash
# Exit 0 = allow, exit 2 = block (stderr shown to Claude).
# This is a harmless placeholder that allows everything. Add real rules or
# delete the hooks/ directory and the "hooks" wiring in hooks.json.
set -euo pipefail

# Claude Code passes the tool input as JSON on stdin.
INPUT=$(cat)

# Fail open: this example never blocks anything.
exit 0
