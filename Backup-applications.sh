#!/bin/bash

set -o errexit
set -o verbose

echo
echo "Backup Applications"
echo

store_path="$HOME/Workspaces/Application/$(date '+%Y-%m-%d-%H')"
mkdir -p "$store_path"

echo "======= Safari ========="
echo
zip -9 -r "$store_path/Safari.zip" ~/Library/Safari
echo

echo "======= Notes ========="
echo
zip -9 -r "$store_path/Notes.zip" "~/Library/Group Containers/group.com.apple.notes"
echo

echo "======= Calendars ========="
echo
zip -9 -r "$store_path/Calendars.zip" ~/Library/Calendars
echo

echo "======= Contacts ========="
echo
zip -9 -r "$store_path/Contacts.zip" ~/Library/Contacts
echo

echo "======= Firefox ========="
echo
zip -9 -r "$store_path/Firefox.zip" "~/Library/Application Support/Firefox"
echo

echo "======= Chrome ========="
echo
zip -9 -r "$store_path/Chrome.zip" "~/Library/Application Support/Google/Chrome"
echo

echo "======= Chromium ========="
echo
zip -9 -r "$store_path/Chromium.zip" "~/Library/Application Support/Chromium"
echo

echo "======= iTerm2 ========="
echo
zip -9 -r "$store_path/iTerm2.zip" "~/Library/Application Support/iTerm2"
echo

echo "======= discord ========="
echo
zip -9 -r "$store_path/discord.zip" "~/Library/Application Support/discord"
echo

echo "======= DuckDuckGo ========="
echo
zip -9 -r "$store_path/DuckDuckGo.zip" "~/Library/Containers/com.duckduckgo.mobile.ios"
echo
