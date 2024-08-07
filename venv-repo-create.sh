#!/usr/local/bin/bash
echo "This script must be sourced, while in a git repo, to function properly"
repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$repo_root" ]; then
    echo "Not in a git repository"
    return 1
fi
venv_path="$repo_root/.venv"
if [ -d "$venv_path" ]; then
    echo ".venv already exists in the repository root"
    return 1
else
    python3 -m venv --prompt repo "$venv_path"
    echo "Created venv at $venv_path"
    source "$venv_path/bin/activate"
    echo "Activated new venv"
fi
