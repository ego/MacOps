#!/usr/bin/env osascript -l JavaScript

console.log("iTerm2 save current open Tabs.");

// iTerm2 docs:
// https://iterm2.com/documentation-scripting.html
// https://iterm2.com/documentation-variables.html

// This script app for display debug things.
var current_app = Application.currentApplication()
current_app.includeStandardAdditions = true

const basePath = "~/Workspaces/iTerm2/Tabs"
const filePath = `${basePath}/$(date '+%Y-%m-%d-%H').txt`

// Traget app.
const iTerm2 = Application("iTerm2")

const tabs = iTerm2.currentWindow().tabs()
var total_tab_count = 0
var fileContent = ""

tabs.forEach((tab) => {
  total_tab_count += 1
  const path = tab.currentSession().variable({named: "path"})
  fileContent += (path + '\n');
});

console.log(`iTerm2 total tabs count: ${total_tab_count}`);
console.log(`Save Finder tabs to file ${basePath}`);

current_app.doShellScript(`mkdir -p ${basePath}`);
current_app.doShellScript(`echo ${JSON.stringify(fileContent)} > ${filePath}`);

result = total_tab_count
