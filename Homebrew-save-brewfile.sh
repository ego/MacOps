#!/bin/bash

echo
echo "Create Brewfile in the directory from currently-installed packages"
echo

file_path="$HOME/Workspaces/Homebrew/$(date '+%Y-%m-%d-%H')"
mkdir -p "$file_path"

echo "brew bundle dump ..."
brew bundle dump --force --file "$file_path/Brewfile"
echo "Save to $file_path/Brewfile"

echo "brew bundle dump ..."
brew list > "$file_path/brew-list.txt"
echo "Save to $file_path/brew-list.txt"

# NOTE:
# To install everything from the Brewfile use command
# brew bundle --file
# brew list > brew-list.txt
# brew deps --tree $(brew leaves)
# brew leaves
