#!/usr/local/bin/bash
echo "This script must be sourced, while in a git repo, to function properly"
repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$repo_root" ]; then
    echo "Not in a git repository"
    return 1
fi
venv_path="$repo_root/.venv"
if [ -d "$venv_path" ]; then
    source "$venv_path/bin/activate"
    echo "Activated venv at $venv_path"
else
    echo "No .venv directory found in the repository root"
    return 1
fi
