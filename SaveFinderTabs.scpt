JsOsaDAS1.001.00bplist00?Vscript__#!/usr/bin/env osascript -l JavaScript

console.log("Get and save Finder tabs.");

const basePath = "~/Workspaces/Finder/Tabs";
const filePath = `${basePath}/$(date '+%Y-%m-%d-%H').txt`;
const Finder = Application("Finder");
Finder.includeStandardAdditions = true;

var tabSet = new Set();
const windows = Finder.finderWindows();
windows.forEach((win) => {
	const tab = win.target();
	// remove "file://"
	const path = decodeURIComponent(tab.url()).slice(7);
	tabSet.add(path);
});


console.log(`Found tabs: ${tabSet.size}.`);
var fileContent = "";
for (const item of tabSet) {
  fileContent += (item + '\n');
};


console.log(`Save Finder tabs to file ${basePath}.`);
app = Application.currentApplication()
app.includeStandardAdditions = true;

app.doShellScript(`mkdir -p ${basePath}`);
app.doShellScript(`echo ${JSON.stringify(fileContent)} > ${filePath}`);

                              u jscr  ??ޭ