JsOsaDAS1.001.00bplist00�Vscript_console.log("Debug script.");

var app = Application.currentApplication()
app.includeStandardAdditions = true

var tab_set = ["Sal", "Ben", "David", "Chris"]
tab_set[4] = "New"
var item = tab_set[4]

result = item
console.log(`${item}`);
app.displayDialog(`Result: ${result}`);
                              ,jscr  ��ޭ