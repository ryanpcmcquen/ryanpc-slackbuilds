#!/bin/sh

find * -type d -print0 | xargs -0 chmod 755
find * -type f -print0 | xargs -0 chmod 644

