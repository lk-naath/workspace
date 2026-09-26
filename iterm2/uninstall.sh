#!/bin/bash

set -euo pipefail

autolaunch_dir="${ITERM2_AUTOLAUNCH_DIR:-$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch}"
support_dir="$HOME/Library/Application Support/iTerm2/Workspace"

rm -f -- "$autolaunch_dir/workspace.py"
rm -f -- "$support_dir/extensions/__init__.py"
rm -f -- "$support_dir/extensions/preferences.py"
rm -f -- "$support_dir/extensions/terminal_ui.py"
rm -f -- "$support_dir/extensions/__pycache__/__init__.cpython-312.pyc"
rm -f -- "$support_dir/extensions/__pycache__/preferences.cpython-312.pyc"
rm -f -- "$support_dir/extensions/__pycache__/terminal_ui.cpython-312.pyc"

rmdir "$support_dir/extensions/__pycache__" 2>/dev/null || true
rmdir "$support_dir/extensions" 2>/dev/null || true
rmdir "$support_dir" 2>/dev/null || true

echo "Removed the workspace iTerm2 plugin. iTerm2 and unrelated AutoLaunch files were left in place."
