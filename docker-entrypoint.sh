#!/bin/sh

bash /elasticsearch_init.sh || exit 1
sh /arkime-capture.sh &
sh /arkime-viewer.sh &
wait
