#!/bin/bash

# set -o errexit

echo
echo "Backup Applications"
echo

store_path="$HOME/Workspaces/Application/$(date '+%Y-%m-%d-%H')"
mkdir -p "$store_path"

echo "======= Safari ========="
zip -9 -r -q "$store_path/Safari.zip" ~/Library/Safari
echo "Done"

echo "======= Notes ========="
zip -9 -r -q "$store_path/Notes.zip" ~/Library/Group\ Containers/group.com.apple.notes
echo "Done"

echo "======= Calendars ========="
zip -9 -r -q "$store_path/Calendars.zip" ~/Library/Calendars
echo "Done"

echo "======= Contacts ========="
zip -9 -r -q "$store_path/Contacts.zip" ~/Library/Contacts
echo "Done"

echo "======= Firefox ========="
zip -9 -r -q "$store_path/Firefox.zip" ~/Library/Application\ Support/Firefox
echo "Done"

echo "======= Chrome ========="
zip -9 -r -q "$store_path/Chrome.zip" ~/Library/Application\ Support/Google/Chrome
echo "Done"

echo "======= Chromium ========="
zip -9 -r -q "$store_path/Chromium.zip" ~/Library/Application\ Support/Chromium
echo "Done"

echo "======= iTerm2 ========="
zip -9 -r -q "$store_path/iTerm2.zip" ~/Library/Application\ Support/iTerm2
echo "Done"

echo "======= discord ========="
zip -9 -r -q "$store_path/discord.zip" ~/Library/Application\ Support/discord
echo "Done"

echo "======= DuckDuckGo ========="
zip -9 -r -q "$store_path/DuckDuckGo.zip" ~/Library/Containers/com.duckduckgo.mobile.ios/Data/Library
echo "Done"
