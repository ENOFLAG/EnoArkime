#!/bin/bash

while ! curl -sq http://elasticsearch:9200; do
        echo "Waiting for elastic search to start...";
        sleep 3;
done

echo "Check if elasticsearch is initalized, otherwise do it"
if [[ ! $(curl -s --head "http://elasticsearch:9200/dstats_v4") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/users_v7") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/fields_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/queries_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/stats_v4") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/sequence_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/hunts_v2") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/files_v6") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearch:9200/lookups_v1") == *"200*" ]]; then
   echo "Initializing elasticsearch..."
   (echo "INIT" | /opt/arkime/db/db.pl http://elasticsearch:9200 init) || exit 1

   echo "Adding Arkime user"
   /opt/arkime/bin/arkime_add_user.sh "arkime" "Arkime User" "arkime" --admin --packetSearch || exit 1
fi
