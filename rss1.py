#!/usr/bin/python

import feedparser
import time
from subprocess import check_output
import sys

feed_name = 'LSM'
#url = 'http://chicagotribune.feedsportal.com/c/34253/f/622872/index.rss'
#url = 'http://www.delfi.lv/rss3.php'
url = 'http://www.lsm.lv/rss/?lang=lv&catid=65'

#feed_name = sys.argv[1]
#url = sys.argv[2]

#db = '/var/www/radio/data/feeds.db'
db = 'c:/temp/feeds.db'
limit = 6 * 3600 * 1000

#
# function to get the current time
#
current_time_millis = lambda: int(round(time.time() * 1000))
current_timestamp = current_time_millis()

feed = feedparser.parse(url)

print(type(feed))


for post in feed.entries:
    title = post.title.encode('UTF-8')
    print(title)



