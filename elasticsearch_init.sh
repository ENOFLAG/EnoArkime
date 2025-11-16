#!/bin/bash

while ! curl --fail -ksq -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" https://opensearch:9200; do
    echo "Waiting for elastic search to start...";
    sleep 3;
done

echo "Check if opensearch is initalized, otherwise do it"
if ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_dstats_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_users_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_fields_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_queries_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_stats_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_sequence_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_hunts_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_files_v30" && \
   ! curl -k -s --head --show-error --fail -u "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" "https://opensearch:9200/arkime_lookups_v30"; then
   echo "Initializing opensearch..."
   (echo "INIT" | /opt/arkime/db/db.pl --esuser "admin:${OPENSEARCH_INITIAL_ADMIN_PASSWORD}" --insecure https://opensearch:9200 init) || exit 1
else
   echo "opensearch was already initalized, so initialization was skipped"
fi
