#!/bin/bash
# kitty includes "/bin/zsh" in its cmdline
ps -ef | grep "/[b]in/zsh" | grep -v kitty | awk '{print $2}'
