
#/data/moloch/db/db.pl http://elasticsearchmoloch:9200 init
#/data/moloch/bin/moloch_add_user.sh "moloch" "moloch" "moloch" --admin
cd viewer
while :
do
  /data/moloch/bin/moloch_add_user.sh "moloch" "moloch" "$MOLOCH_PASSWORD" --admin
  sleep 10
done
