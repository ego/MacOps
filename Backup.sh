#!/bin/bash

set -o errexit
set -o verbose

echo
echo "Run all scripts"
echo

./Homebrew-save-brewfile.sh
echo "=================="
echo

./iTerm2-save-tabs.sh
echo "=================="
echo

./Safari-save-tabs.sh
echo "=================="
echo

./Finder-save-tabs.sh
echo "=================="
echo

./Sublime-save-files-history.sh
echo "=================="
