#!/bin/bash

SUCCESS=1
until [ $SUCCESS == 0 ]; do
    curl -X GET "elasticsearch:9200/_cluster/health?wait_for_status=yellow&timeout=120s&pretty"
    SUCCESS=$?
    sleep 3
done

sleep 15

/data/moloch/bin/moloch-capture --host moloch-capture -R /data/moloch/raw/ -m

