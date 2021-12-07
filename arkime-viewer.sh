cd /opt/arkime/viewer
while :
do
  echo "Starting Moloch viewer"
  /opt/arkime/bin/node viewer.js -c /opt/arkime/etc/config.ini -n enomoloch
  sleep 5
done
