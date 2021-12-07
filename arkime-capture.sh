cd /opt/arkime
while :
do
  echo "Starting Arkime capture"
  /opt/arkime/bin/capture -c /opt/arkime/etc/config.ini -R /opt/arkime/raw -m -n enoarkime
  sleep 5
done
