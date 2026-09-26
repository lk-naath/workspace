#!/bin/bash

set -euo pipefail

# ===============================================================================
#                            Development
# ===============================================================================

repo_root="${WORKSPACE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

# Keep extensions outside AutoLaunch. iTerm2 treats entries inside that folder
# as scripts, while this support directory is only used for Python imports.

# ===============================================================================
#                               Cleanup
# ===============================================================================

autolaunch_dir="${ITERM2_AUTOLAUNCH_DIR:-$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch}"
support_dir="$HOME/Library/Application Support/iTerm2/Workspace"

# Remove the old layout that put an extensions/ directory in AutoLaunch.
if [[ -e "$autolaunch_dir/extensions" || -L "$autolaunch_dir/extensions" ]]; then
	source "$repo_root/utils.sh"
	echo "The old extensions entry is inside AutoLaunch and iTerm2 may try to run it."
	confirm_delete "$autolaunch_dir/extensions"
fi

# ===============================================================================
#                            Installation
# ===============================================================================

mkdir -p "$autolaunch_dir"
mkdir -p "$support_dir"

# Copy into the support package directory so rerunning setup updates modules
# without removing unrelated iTerm2 files.
mkdir -p "$support_dir/extensions"
cp -R "$repo_root/iterm2/extensions/." "$support_dir/extensions/"
install -m 755 "$repo_root/iterm2/plugin.py" "$autolaunch_dir/workspace.py"

echo "Configured workspace.py in $autolaunch_dir and extensions in $support_dir."
