#!/usr/local/bin/bash

# ${BASH_SOURCE[0]} is the name of the current script as it appears in the call stack.
# ${0} is the name of the script as it was invoked.

# When a script is sourced, these two values will be different. When a script is executed in a subshell, they will be the same.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script needs to be sourced. Please run it as:"
    echo "source ${0}"
    exit 1
fi

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
    echo "Running: python3 -m venv --prompt repo \"$venv_path\""
    python3 -m venv --prompt repo "$venv_path"
    echo "Created venv at $venv_path"
    source "$venv_path/bin/activate"
    echo "Activated new venv"
fi
