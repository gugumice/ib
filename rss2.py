#!/usr/bin/python3
import feedparser
import sys, time, argparse

parser = argparse.ArgumentParser(description='Save RSS feed to file')
parser.add_argument('rss',metavar='RSS',type=str,help='URL for RSS feed')
parser.add_argument('path',metavar='Path',type=str,help='Path to news file')
parser.add_argument('-s','--short', dest='short', action='store_true',help='News titles only')
parser.add_argument('-v','--verbose', dest='verbose', action='store_true',help='Show RSS feed')

entry=None

args=parser.parse_args()
print(args)
path = args.path
url = args.rss
short=args.short
verbose=args.verbose
try:
    f = feedparser.parse(url)
except Exception as e:
    print('Error pharsing {}\n{}'.format(url,e))
    sys.exit(1)
if len(f.entries) == 0:
    print("No feed in {}!".format(url))
    sys.exit(0)
try:
    fl=open(path,'w')
    fl.truncate()
except Exception as e:
    print("Can't open file\n{}".format(e))
    sys.exit()
fd=feedparser.parse(url)
entry="{} ziņas".format(fd.feed.title)

if verbose:
    print(entry)
fl.write(entry)

for post in fd.entries:
    if short:
        entry="{}".format(post.title)
    else:
        entry="{}".format(post.summary)
    if verbose:
        print(entry)
    fl.write(entry)
fl.close
