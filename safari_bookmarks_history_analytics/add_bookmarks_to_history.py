"""
This script add Bookmarks.plist data into History.db.
Creates new tables.

1) Copy files:
    mkdir -p Safari
    cp ~/Library/Safari/History.db       Safari/
    cp ~/Library/Safari/Bookmarks.plist. Safari/
2) Run python3 add_bookmarks_to_history.py
3) Execute SQL query: Query.sql (with any SQLite client)
4. Look at the data `diff` between `Bookmarks.plist` and `History.db` from result of SQL query.
"""

import os
import re
import sqlite3
import plistlib
import csv
import pandas as pd


History   = os.path.join(*"Safari/History.db".split("/"))
Bookmarks = os.path.join(*"Safari/Bookmarks.plist".split("/"))


def camel_to_snake(name):
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()


def build_db_record(bookmark):
    flattened = {}
    for key in ("WebBookmarkUUID", "WebBookmarkType", "Title", "WebBookmarkIdentifier", "URLString"):
        if key in bookmark:
            flattened[camel_to_snake(key)] = bookmark.get(key)
        
        uri_dictionary_title = (bookmark.get("URIDictionary") or {}).get("title")
        if uri_dictionary_title:
            flattened[camel_to_snake("URIDictionaryTitle")] = uri_dictionary_title
    return flattened


def create_table_name(input_string):
    sanitized_string = re.sub(r'[^a-zA-Z0-9]', '_', input_string)
    return sanitized_string.lower()


def bookmarks_plist_to_csv(bookmarks_plist=Bookmarks):
    with open(bookmarks_plist, "rb") as fp:
        plist_data = plistlib.load(fp)

    for bookmark in plist_data.get("Children", []):
        if bookmark.get("Children"):
            print("Found tabs group", len(bookmark["Children"]))
            db_table_records = [build_db_record(children_bookmark) for children_bookmark in bookmark["Children"]]
            for indx, record in enumerate(db_table_records):
                record[camel_to_snake("PositionalIndex")] = indx

            # Export to CSV
            df = pd.DataFrame(db_table_records)
            table_name = create_table_name(bookmark["Title"])

            csv_file_name = str(os.path.join("Bookmarks", table_name))
            df.to_csv(csv_file_name, index=False)
            print(f"Conversion to CSV completed {csv_file_name}.")


def bookmarks_plist_into_history_db(
        bookmarks_plist=Bookmarks,
        history_db=History,
    ):
    with open(bookmarks_plist, "rb") as fp:
        plist_data = plistlib.load(fp)

    db_conn = sqlite3.connect(history_db)
    for bookmark in plist_data.get("Children", []):
        if bookmark.get("Children"):
            print("Found tabs group", len(bookmark["Children"]))
            db_table_records = [build_db_record(children_bookmark) for children_bookmark in bookmark["Children"]]
            for indx, record in enumerate(db_table_records):
                record[camel_to_snake("PositionalIndex")] = indx

            table_name = create_table_name(bookmark["Title"])
            # Export to DB
            df = pd.DataFrame(db_table_records)
            df.to_sql(table_name, db_conn, if_exists='replace', index=False)
            print(f"New table {table_name} was creaed and {len(db_table_records)} rows inserted.")
    db_conn.close()


bookmarks_plist_into_history_db()
