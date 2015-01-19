#!/bin/sh

## UNIX-like, eh?

cd

sbopkg -r

cd /var/lib/sbopkg/

## bet you didn't know xargs could do this  ;-)
ls -t --color=never | head -1 | xargs -L 1 sh -c 'cd "$0" && pwd' > ~/ryanpc-slackbuilds/sbopkg-current-directory

cd "$(tr -d '\n\r' < ~/ryanpc-slackbuilds/sbopkg-current-directory)"

grep -i Ryan\ P.C.\ McQuen */*/*.info | cut -d/ -f2-2 | sort | awk '{print "http://slackbuilds.org/apps/"$0"/\n"}' > ~/ryanpc-slackbuilds/README.md

rm ~/ryanpc-slackbuilds/sbopkg-current-directory

cd ~/ryanpc-slackbuilds/

