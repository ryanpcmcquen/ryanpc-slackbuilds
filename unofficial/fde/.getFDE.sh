#!/bin/sh
## grab and install the latest firefox developer edition

if [ ! $UID = 0 ]; then
  cat << EOF
This script must be run as root.
EOF
  exit 1
fi

cd

wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/README -P ~/fde/
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/doinst.sh -P ~/fde/
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/fde.SlackBuild -P ~/fde/
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/fde.info -P ~/fde/
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/slack-desc -P ~/fde/

## keep this file around for updates
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/.getFDE.sh -P ~/

## automatic daily updates!
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/.getFDE.sh -P /etc/cron.daily/
chmod 755 /etc/cron.daily/.getFDE.sh


cd ~/fde/

. ~/fde/fde.info

wget ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/ \
  -O ~/fde-download-page.html
grep firefox ~/fde-download-page.html | grep .tar.bz2 | head -1 \
  | cut -d'"' -f8 > ~/fdeVersion32
grep firefox ~/fde-download-page.html | grep .tar.bz2 | head -2 \
  | tail -1 | cut -d'"' -f8 > ~/fdeVersion64
rm -v ~/fde-download-page.html 
export FDEVER32=${FDEVER32="$(tr -d '\n\r' < ~/fdeVersion32)"}
export FDEVER64=${FDEVER64="$(tr -d '\n\r' < ~/fdeVersion64)"}


if [ "$(uname -m)" = "x86_64" ]; then
  wget -N ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/$FDEVER64 \
    -P ~/fde/
else
  wget -N ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/$FDEVER32 \
    -P ~/fde/
fi

## run it!
cd ~/fde/
sh fde.SlackBuild

## install version with latest timestamp
ls -t --color=never /tmp/fde-*_SBo.tgz | head -1 | xargs -i upgradepkg --reinstall --install-new {}

## clean up
rm -v ~/fde/*.tar.bz2
rm -v ~/fdeVersion32
rm -v ~/fdeVersion64

