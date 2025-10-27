#!/bin/sh
touch /etc/frr/vtysh.conf
/usr/lib/frr/docker-start &
while :; do
  /usr/bin/vtysh ;
  echo '==> NOPE ! Exiting the shell would also stop the Docker container! Please close the terminal window instead.';
done
