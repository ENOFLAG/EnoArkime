#!/bin/bash

while ! curl -sq http://elasticsearch:9200; do
    echo "Waiting for elastic search to start...";
    sleep 3;
done

echo "Check if elasticsearch is initalized, otherwise do it"
if ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_dstats_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_users_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_fields_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_queries_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_stats_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_sequence_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_hunts_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_files_v30" && \
   ! curl -s --head --show-error --fail "http://elasticsearch:9200/arkime_lookups_v30"; then
   echo "Initializing elasticsearch..."
   (echo "INIT" | /opt/arkime/db/db.pl http://elasticsearch:9200 init) || exit 1

   echo "Adding Arkime user"
   /opt/arkime/bin/arkime_add_user.sh "arkime" "Arkime User" "arkime" --admin --packetSearch || exit 1
else
   echo "elasticsearch was already initalized, so initialization was skipped"
fi
