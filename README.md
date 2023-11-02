# MacOps

Backup data from major macOS Applications.

<img src="img/MacOps.png" width="400" />

## Motivation

Sometimes application state can be broken, so we need a way to restore it, especially when macOS cannot do it (after update).

## Run these scripts before close App, reboot, upgrade macOS.

## Install

```shell
git clone https://github.com/ego/MacOps.git
```

## Features:

* Homebrew save Brewfile and brew --list commands

`./Homebrew-save-brewfile.sh`

* iTerm2 save open current Tabs

`./iTerm2-save-tabs.sh`

* Safari save open current Tabs

`./Safari-save-tabs.sh`

* Finder save open current Tabs

`./Finder-save-tabs.sh`

* Sublime save open current Tabs

Open Sublime and go to View/Show Console

<img src="img/Sublime-show-console.png" width="400" />

and paste content from

`Sublime-save-tabs.py`

<img src="img/Sublime-console-code.png" width="400" />

* Sublime save files history

`./Sublime-save-files-history.sh`


### Debug

AppleScript and JavaScript for Automation (JXA).
Python and Bash for scripting.

<img src="img/Debug-JXA.png" width="400" />

Use [Script Editor on Mac](https://support.apple.com/en-gb/guide/script-editor/scpedt6935/mac)

`open osascript/Debug.scpt`

Print logs or alert pop-ups:

`console.log("") and  app.displayDialog("")`

```JavaScript
var app = Application.currentApplication()
app.includeStandardAdditions = true

var array = ["Sal", "Ben", "David", "Chris"]
var arrayLength = array.length

for (var i = 0; i < arrayLength; i++) {
    var currentArrayItem = array[i]
    // Process the current array item
    app.displayDialog(`${currentArrayItem} is item ${i + 1} in the array.`)
}
```

[Mac Automation Scripting Guide](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/ManipulateListsofItems.html)

[JXA](https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation)

[Closing lots of Safari tabs with JXA](https://alexwlchan.net/2022/safari-tabs/)

[JavaScript for Automation](https://wiki.keyboardmaestro.com/JavaScript_for_Automation)

[Apple JavaScript for Automation](https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/Introduction.html#//apple_ref/doc/uid/TP40014508)

[Introduction to AppleScript Language Guide](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html#//apple_ref/doc/uid/TP40000983)

[PyXA](https://skaplanofficial.github.io/PyXA/tutorial/appscript.html)
[appscript](https://appscript.sourceforge.io)
[py-appscript](https://appscript.sourceforge.io/py-appscript/doc.html)
[pyobjc](https://pypi.org/project/pyobjc/)
