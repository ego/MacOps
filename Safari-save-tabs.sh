#!/usr/bin/env osascript -l JavaScript

console.log("Safari save open tabs.");

// This script app for display debug things.
var current_app = Application.currentApplication()
current_app.includeStandardAdditions = true

// Save to dir.
const basePath = "~/Workspaces/Safari/Tabs"
const filePath = `${basePath}/$(date '+%Y-%m-%d-%H').txt`

// Traget app.
const Safari = Application("Safari")
Safari.includeStandardAdditions = true

const window_count = Safari.windows.length
var total_tab_count = 0
var fileContent = "";

for (var window_index = window_count - 1; window_index >= 0; window_index--) {
  this_window = Safari.windows[window_index]

  // Inc total tabs.
  tab_count = this_window.tabs.length
  total_tab_count += tab_count

  for (var tab_index = 0; tab_index < tab_count; tab_index ++) {
    tab = this_window.tabs[tab_index]
  fileContent += (tab.url() + '\n')
  // Also you can use tab.name()
  }

}

console.log(`Found Safari tabs: ${total_tab_count}`)
console.log(`Save Safari tabs to dir ${basePath}`)

current_app.doShellScript(`mkdir -p ${basePath}`)
current_app.doShellScript(`echo ${JSON.stringify(fileContent)} > ${filePath}`)

result = total_tab_count
