#!/bin/sh

while ! curl -sq http://elasticsearchmoloch:9200; do
        echo "Waiting for elastic search to start...";
        sleep 3;
done

./moloch-viewer.sh

