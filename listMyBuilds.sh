#!/bin/sh

## UNIX-like, eh?

cd

sbopkg -r

cd /var/lib/sbopkg/SBo/

grep -i Ryan\ P.C.\ McQuen */*/*.info | cut -d/ -f2-2 | sort | awk '{print "http://slackbuilds.org/apps/"$0"/\n"}' > ~/ryanpc-slackbuilds/README.md

cd ~/ryanpc-slackbuilds/

