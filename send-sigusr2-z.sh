#!/bin/sh
#
# sends SIGUSR2 to all running zsh instances
# I have a trap set in zsh to trigger updating the prompt char based on moon phase
# see ~/.config/zsh/functions/post_powerlevel10k-ev
SCRIPT_PATH="$0"
while [ -L "$SCRIPT_PATH" ]; do
  SCRIPT_PATH="$(readlink -- "$SCRIPT_PATH")"
done
SCRIPT_DIR="$(cd -- "$(dirname -- "$SCRIPT_PATH")" && pwd)"

"$SCRIPT_DIR/get-pids-of-z.sh" | xargs kill -USR2

echo "$(date): sent SIGUSR2 to zshes"
"$SCRIPT_DIR/get-pids-of-z.sh"
