cd /opt/arkime
while :
do
  echo "Starting Arkime capture"
  /opt/arkime/bin/capture -c /opt/arkime/etc/config.ini -R /opt/arkime/raw -m -n enoarkime --insecure
  sleep 5
done
