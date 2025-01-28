#!/bin/bash
launchctl unload ~/Library/LaunchAgents/local.tomatobar-ev-watcher.plist && \
launchctl load -w ~/Library/LaunchAgents/local.tomatobar-ev-watcher.plist
