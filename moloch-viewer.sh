
#/data/moloch/db/db.pl http://elasticsearchmoloch:9200 init
#/data/moloch/bin/moloch_add_user.sh "moloch" "moloch" "moloch" --admin
cd viewer
while :
do
  echo "Starting Moloch viewer"
  ../bin/node ./viewer.js
  sleep 5
done
