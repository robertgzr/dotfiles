#!/usr/bin/env zsh

dockutil --no-restart --remove all
dockutil --no-restart --add "$HOME/Applications/FirefoxNightly.app"
dockutil --no-restart --add "$HOME/Applications/MacPass.app"
dockutil --no-restart --add "/Applications/Transmission.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Mail.app"
dockutil --no-restart --add "/Applications/Sublime Text.app"
dockutil --no-restart --add "$HOME/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/iTunes.app"
dockutil --no-restart --add "/Applications/System Preferences.app"

killall Dock