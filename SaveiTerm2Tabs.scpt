JsOsaDAS1.001.00bplist00?Vscript_?#!/usr/bin/env osascript -l JavaScript

console.log("Get and save iTerm tabs.");

const basePath = "~/Workspaces/iTerm2/Tabs";
const filePath = `${basePath}/$(date '+%Y-%m-%d-%H').txt`;
const iTerm2 = Application("iTerm2");
iTerm2.includeStandardAdditions = true;

var tabSet = new Set();
const tabs = iTerm2.currentWindow().tabs();
JSON.stringify(tabs.length);

tabs.forEach((tab) => {
	// iterm2 https://iterm2.com/documentation-scripting.html
	// Variables: https://iterm2.com/documentation-variables.html
	const path = tab.currentSession().variable({named: "path"})
	tabSet.add(path)
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
                              ?jscr  ??ޭ