#!/bin/bash

# https://unix.stackexchange.com/questions/548806/how-to-get-just-two-items-of-a-json-like-file
# https://softhints.com/recover-unsaved-files-sublime-linux-mac/#google_vignette

SUBLIME_TABS_PATH=~/Workspaces/Sublime/FileHistory
SUBLIME_FILE_NAME="$(date '+%Y-%m-%d-%H').txt"
SUBLIME_LOCAL_FIND=`find ~/'Library/Application Support/Sublime Text/Local' -maxdepth 1 -type f -name "*.sublime_session"`

echo
echo 'Parse and save Sublime tabs ...'
echo

mkdir -p "$SUBLIME_TABS_PATH"

OIFS="$IFS"
IFS=$'\n'

for file in $SUBLIME_LOCAL_FIND
do
    echo "Processing file: $file"
    jq -r '.. | .file_history?' "$file" | jq -r '.. | .[]?' >> "$SUBLIME_TABS_PATH/_$SUBLIME_FILE_NAME"
    echo "------------------------------------------------------------"
    echo
done

IFS="$OIFS"

awk '!seen[$0]++' "$SUBLIME_TABS_PATH/_$SUBLIME_FILE_NAME" > "$SUBLIME_TABS_PATH/$SUBLIME_FILE_NAME"
rm "$SUBLIME_TABS_PATH/_$SUBLIME_FILE_NAME"
echo "Saved Sublime file history to $SUBLIME_TABS_PATH/$SUBLIME_FILE_NAME"

echo 'Done'
