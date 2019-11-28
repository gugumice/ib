#!/usr/bin/python3
import feedparser
import sys, time, argparse

parser = argparse.ArgumentParser(description='Save RSS feed entry to file')
parser.add_argument('rss',metavar='RSS',type=str,help='URL for RSS feed')
parser.add_argument('path',metavar='Path',type=str,help='Path to news file')
parser.add_argument('entry', nargs='?', metavar='Entry', type=str, default='title', help='RSS entry. Default: summary')
parser.add_argument('-e','--entries', dest='entries_list', action='store_true',help='List avilable RSS entries')
parser.add_argument('-v','--verbose', dest='verbose', action='store_true',help='Show RSS feed')

args=parser.parse_args()
path = args.path
url = args.rss
entries_list=args.entries_list
verbose=args.verbose
entry_name=args.entry
#print(args)

txt_entry=None
try:
    f = feedparser.parse(url)
except Exception as e:
    print('Error pharsing {}\n{}'.format(url,e))
    sys.exit(1)

if len(f.entries) == 0:
    print("No feed in {}!".format(url))
    sys.exit(0)
if entries_list:
    e = list(f.entries[0].keys())
    for cnt,item in enumerate(e):
        print("{}.\t{}".format(cnt+1,item))
    sys.exit(0)
try:
    fl=open(path,'w')
    fl.truncate()
except Exception as e:
    print("Can't open file\n{}".format(e))
    sys.exit()
fd=feedparser.parse(url)
txt_entry="{} ziņas\n".format(fd.feed.title)
if verbose:
    print(txt_entry)
fl.write(txt_entry)

for post in fd.entries:
    #print(post[entry_name])
    txt_entry="{}".format(post[entry_name])
    if verbose:
        print("{}".format(txt_entry))
    fl.write("{}\n".format(txt_entry))
fl.close
