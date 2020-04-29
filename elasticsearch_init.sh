#!/bin/bash

while ! curl -sq http://elasticsearchmoloch:9200; do
        echo "Waiting for elastic search to start...";
        sleep 3;
done

echo "Check if elasticsearch is initalized, otherwise do it"
if [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/dstats_v4") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/users_v7") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/fields_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/queries_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/stats_v4") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/sequence_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/hunts_v2") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/files_v6") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/lookups_v1") == *"200*" ]]; then
   echo "Initializing elasticsearch..."
   (echo "INIT" | /data/moloch/db/db.pl http://elasticsearchmoloch:9200 init) || exit 1

   [ -z "$MOLOCH_USER" ] && MOLOCH_USER="moloch"
   [ -z "$MOLOCH_PASSWORD" ] && MOLOCH_PASSWORD="moloch"
   echo "Adding user: $MOLOCH_USER"
   /data/moloch/bin/moloch_add_user.sh "$MOLOCH_USER" "$MOLOCH_USER" "$MOLOCH_PASSWORD" --admin --packetSearch || exit 1
fi

