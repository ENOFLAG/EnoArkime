cd /opt/arkime/viewer
while :
do
  echo "Starting Arkime viewer"
  /opt/arkime/bin/node viewer.js -c /opt/arkime/etc/config.ini -n enoarkime
  sleep 5
done
