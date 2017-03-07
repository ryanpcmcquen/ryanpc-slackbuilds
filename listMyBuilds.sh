#!/bin/sh

## UNIX-like, eh?

cd

sbopkg -r

cd /var/lib/sbopkg/SBo/

grep -r 'MAINTAINER="Ryan P.C. McQuen"' . | cut -d/ -f3-3 | sort | awk '{print "https://slackbuilds.org/apps/"$0"/\n"}' > ~/ryanpc-slackbuilds/README.md

cd ~/ryanpc-slackbuilds/

