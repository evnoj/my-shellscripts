#!/bin/bash
# kitty includes "/bin/zsh" in its cmdline
ps -ef | rg -e "/bin/[z]sh" -e "-[z]sh" | rg -v kitty | awk '{print $2}'
