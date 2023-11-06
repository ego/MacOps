# Safari Bookmarks and History Analytics

## Requirements

* python3
* pandas
`pip3 install pandas`


## add_bookmarks_to_history.py

Parse `Bookmarks.plist` and add (insert) this data into `History.db` to next `diff` SQL `query`. This script will `creates` new tables in `History.db`.

Usefull when Safari crashed and your try to `restore TABS from Hostory`.

The algorithm:

1. Copy files:

```shell
mkdir -p Safari
cp ~/Library/Safari/History.db       Safari/
cp ~/Library/Safari/Bookmarks.plist. Safari/
```

2. Run
```shell
python3 add_bookmarks_to_history.py
```

3. With any SQLite client `execute` `SQL query` to find URLs diff, like in `Query.sql`
    DIFF: (history_visits + history_items) || saved_tabs_table_name
    Change to YOURS CRASH DATES in line: 27
    Change to YOURS table FROM ... in line: 41

4. Look at the data `diff` between `Bookmarks.plist` and `History.db`  from result of SQL query:
    `unique_rows` = `history_visits` + `history_items` `diff` `tabs`.


## last_session_plist_to_csv.py

This script save `LastSession.plist` as `LastSession.csv`
Creates new tables.

1. Copy files:

```shell
mkdir -p Safari
cp ~/Library/Safari/LastSession.plist. Safari/
```

2. Run 

```shell
python3 last_session_plist_to_csv.py
```
