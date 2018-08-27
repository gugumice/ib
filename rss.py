#!/usr/bin/python
import feedparser
import sys
import time
feed_name = sys.argv[1]
url = sys.argv[2]
target = sys.argv[3]

feed = feedparser.parse(url)
if len(feed.entries) == 0:
        print("No feed in "+url)
        sys.exit()


try:
        f=open(target,'w')
        f.truncate()
except:
        print("Can't open file")
        sys.exit()

f.write(feed_name+"\n")


for post in feed.entries:
        title = post.title.encode('UTF-8')
        print(title)
        f.write(title+"\n")
f.close
