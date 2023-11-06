"""
This script save LastSession.plist as LastSession.csv
Creates new tables.

1. Copy files:
    mkdir -p Safari
    cp ~/Library/Safari/LastSession.plist. Safari/
2. Run python3 last_session_plist_to_csv.py
"""

import os
import sqlite3
import plistlib
import pandas as pd

plist_file = os.path.join(*"Safari/LastSession.plist".split("/"))  # Replace with the actual file path
csv_file = os.path.join(*"Safari/LastSession.csv".split("/"))      # Replace with the desired CSV file path

# Load the plist file
with open(plist_file, "rb") as fp:
    plist_data = plistlib.load(fp)

# Extract relevant data (modify this based on the structure of your plist)
tabs_data = []
for window in plist_data["SessionWindows"]:
    for tab in window["TabStates"]:
        row = {}
        for key in ("DateClosed", "TabIndex", "LastVisitTime", "TabUUID", "TabURL", "TabTitle", "TabIdentifier",):
            row[key] = tab.get(key)
        tabs_data.append(row)

# Convert to a pandas DataFrame
df = pd.DataFrame(tabs_data)

# Export to CSV
df.to_csv(csv_file, index=False)

print(f"Conversion to CSV completed {csv_file}.")
