# Restore safari tabs

`restore_safari_tabs.py`

This script parse safari tabs from files:

    ~/Library/Safari/History.db
    ~/Library/Safari/RecentlyClosedTabs.plist
    ~/Library/Safari/LastSession.plist
    ~/Library/Safari/TopSites.plist

and create index.html in current folder with all URLS.


## Requirements

* python3

## Pre-requirements

Before run this script you need to copy these files into directory current folder `./Safari/`: 

```shell
mkdir -p Safari
cp ~/Library/Safari/History.db               Safari/
cp ~/Library/Safari/RecentlyClosedTabs.plist Safari/
cp ~/Library/Safari/LastSession.plist        Safari/
cp ~/Library/Safari/TopSites.plist           Safari/
```

## Configure

* Put your SQL `LIKE` strings in file: `URL_NOT_LIKE.txt` for skip this URL.

* Put your strings in file: `DOMAIN_EXPANSION_NOT_IN.txt` for skip this domain.


## Run

```shell
python3 restore_safari_tabs.py
```
