"""
restore_safari_tabs.py

This script parse Safari tabs.

Pre-requirements:

mkdir -p Safari
cp ~/Library/Safari/History.db               Safari/
cp ~/Library/Safari/RecentlyClosedTabs.plist Safari/
cp ~/Library/Safari/LastSession.plist        Safari/
cp ~/Library/Safari/TopSites.plist           Safari/

It will ./Safari/index.html with all URLs.
"""

import os
import logging
from pathlib import Path
import sqlite3
import plistlib


logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG, format="%(asctime)s %(levelname)s %(message)s")

History            = os.path.join(*"Safari/History.db".split("/"))
RecentlyClosedTabs = os.path.join(*"Safari/RecentlyClosedTabs.plist".split("/"))
LastSession        = os.path.join(*"Safari/LastSession.plist".split("/"))
TopSites           = os.path.join(*"Safari/TopSites.plist".split("/"))
Index              = os.path.join(*"Safari/index.html".split("/"))
URL_NOT_LIKE_TXT            = os.path.join(*"Safari/URL_NOT_LIKE.txt".split("/"))
DOMAIN_EXPANSION_NOT_IN_TXT = os.path.join(*"Safari/DOMAIN_EXPANSION_NOT_IN.txt".split("/"))


with open("URL_NOT_LIKE.txt") as fd:
    URL_NOT_LIKE = [f"AND url NOT LIKE '{i.strip()}'" for i in tuple(fd.readlines())]
    if os.path.exists(URL_NOT_LIKE_TXT):
        with open(URL_NOT_LIKE_TXT) as fd:
            URL_NOT_LIKE += [f"AND url NOT LIKE '{i.strip()}'" for i in tuple(fd.readlines())]

with open("DOMAIN_EXPANSION_NOT_IN.txt") as fd:
    DOMAIN_EXPANSION_NOT_IN = tuple(i.strip() for i in fd.readlines())
    if os.path.exists(DOMAIN_EXPANSION_NOT_IN_TXT):
        with open(DOMAIN_EXPANSION_NOT_IN_TXT) as fd:
            DOMAIN_EXPANSION_NOT_IN += tuple(i.strip() for i in fd.readlines())


def recently_closed_tabs():
    logger.info(f"Start process {RecentlyClosedTabs}")
    with open(f"{RecentlyClosedTabs}", "rb") as fp:
        data = plistlib.load(fp)

    urls = []
    for item in data["ClosedTabOrWindowPersistentStates"]:
        val = item["PersistentState"].get("TabURL")
        if val:
            urls.append(val)
    logger.info(f"Finish process {RecentlyClosedTabs} count %s", len(urls))
    return urls


def last_session():
    logger.info(f"Start process {LastSession}")
    with open(f"{LastSession}", "rb") as fp:
        data = plistlib.load(fp)

    urls = []
    for item in data["SessionWindows"]:
        for tab in item.get("TabStates"):
            val = tab.get("TabURL")
            if val:
                urls.append(val)

    logger.info(f"Finish process {LastSession} count %s", len(urls))
    return urls


def top_sites():
    logger.info(f"Start process {TopSites}")
    with open(f"{TopSites}", "rb") as fp:
        data = plistlib.load(fp)

    urls = []
    for item in data["TopSites"]:
        val = item.get("TopSiteURLString")
        if val:
            urls.append(val)

    logger.info(f"Finish process {TopSites} %s", len(urls))
    return urls


def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d


def history():
    logger.info(f"Start process {History}")
    conn = sqlite3.connect(f"{History}")
    conn.row_factory = dict_factory
    cursor = conn.cursor()
    query = f"""
        SELECT DISTINCT history_items.url FROM history_items WHERE
        visit_count > 1
        {' '.join(URL_NOT_LIKE)}
        AND domain_expansion NOT IN {DOMAIN_EXPANSION_NOT_IN}
        ORDER BY id DESC, visit_count DESC, visit_count_score DESC;
    """
    # logger.info("Query:\n %s", query)
    rows = cursor.execute(query)
    urls = [row["url"] for row in rows]
    logger.info(f"Finish process {History} count %s", len(urls))
    return urls


def build_html(urls):
    logger.info("Start build HTML with URLs")
    html = """
    <!DOCTYPE html>
    <html>
      <head>
        <title>URLS</title>
      </head>
      <body>
        <h1>URLS</h1>
        <ul style="list-style-type:none;">
        {}
        </ul>
      </body>
    </html>
    """
    li = [
        f"<li><span>{index}</span> - <a href='{url}'>{url}</a></li>"
        for index, url in enumerate(urls)
    ]
    with open(f"{Index}", "w") as fd:
        fd.write(html.format("".join(li)))
    logger.info("Finish build HTML with URLs")
    logger.info(f"Saved to {Index}")


def main():
    history_data = history()
    tabs_data = recently_closed_tabs()
    sites_data = top_sites()
    session_data = last_session()

    urls = set(history_data + tabs_data + sites_data) - set(session_data)
    count = len(urls)
    logger.info("Result count %s", count)

    build_html(urls)


if __name__ == "__main__":
    main()
