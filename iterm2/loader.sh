#!/bin/bash

set -euo pipefail

repo_root="${WORKSPACE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
autolaunch_dir="${ITERM2_AUTOLAUNCH_DIR:-$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch}"
source "$repo_root/utils.sh"

mkdir -p "$autolaunch_dir"

# AutoLaunch runs .py files and full-environment folders. Keep extensions as
# an importable archive so iTerm2 won't try to run the source directory.
confirm_delete "$autolaunch_dir/extensions"
confirm_delete "$autolaunch_dir/workspace.py"

ditto -c -k --norsrc --keepParent "$repo_root/iterm2/extensions" "$autolaunch_dir/extensions"
install -m 755 "$repo_root/iterm2/plugin.py" "$autolaunch_dir/workspace.py"

echo "Configured workspace.py and the extensions archive in $autolaunch_dir."
