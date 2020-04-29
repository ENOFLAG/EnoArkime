#!/bin/sh

bash ./elasticsearch_init.sh || exit 1
./moloch-capture.sh
