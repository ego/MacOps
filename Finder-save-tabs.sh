#!/usr/bin/env osascript -l JavaScript

console.log("Finder save open tabs.");

// This script app for display debug things.
var current_app = Application.currentApplication()
current_app.includeStandardAdditions = true

// Save to dir.
const basePath = "~/Workspaces/Finder/Tabs"
const filePath = `${basePath}/$(date '+%Y-%m-%d-%H').txt`

// Traget app.
const Finder = Application("Finder")
var total_tab_count = 0
var fileContent = ""

const windows = Finder.finderWindows()
windows.forEach((win) => {
  total_tab_count += 1
  const tab = win.target()
  const path = decodeURIComponent(tab.url()).slice(7)  // remove "file://"
  fileContent += (path + '\n')
});

console.log(`Found Finder tabs: ${total_tab_count}`)
console.log(`Save Finder tabs to dir ${basePath}`)

current_app.doShellScript(`mkdir -p ${basePath}`)
current_app.doShellScript(`echo ${JSON.stringify(fileContent)} > ${filePath}`)

result = total_tab_count
