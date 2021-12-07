cd /opt/arkime
while :
do
  echo "Starting Moloch capture"
  /opt/arkime/bin/capture -c /opt/arkime/etc/config.ini -R /opt/arkime/raw -m -n enomoloch
  sleep 5
done
