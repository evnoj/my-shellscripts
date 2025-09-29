#!/bin/zsh

# prints out the colors 0-255
for i in {0..255}; printf "\e[48;5;${i}m %3d \e[0m" $i; echo
