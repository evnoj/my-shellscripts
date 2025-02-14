#!/bin/bash

# reloads the launchagent that sets the wallpaper to red when tomatobar has a work timer going
# run this script while tomatobar is not in work state (can be running)
launchctl unload ~/Library/LaunchAgents/local.tomatobar-ev-watcher.plist && \
launchctl load -w ~/Library/LaunchAgents/local.tomatobar-ev-watcher.plist
