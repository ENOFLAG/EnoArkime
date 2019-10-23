#!/bin/bash
if [ -z "$MOLOCH_USER" ]; then
    MOLOCH_USER="moloch"
fi

if [ -z "$MOLOCH_PASSWORD" ]; then
    MOLOCH_PASSWORD="moloch"
fi

SUCCESS=1
until [ $SUCCESS == 0 ]; do
    curl -X GET "elasticsearch:9200/_cluster/health?wait_for_status=yellow&timeout=120s&pretty"
    SUCCESS=$?
    sleep 3
done

set -e

/data/moloch/db/db.pl http://elasticsearch:9200 init
/data/moloch/bin/moloch_add_user.sh "$MOLOCH_USER" "$MOLOCH_NAME" "$MOLOCH_PASSWORD" --admin
cd viewer && /data/moloch/bin/node ./viewer.js || sleep 100000
