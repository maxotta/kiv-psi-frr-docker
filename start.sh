#!/bin/sh
touch /etc/frr/vtysh.conf

export BGPD=${ENABLE_BGP:-no}
export OSPFD=${ENABLE_OSPF:-no}
export OSPF6D=${ENABLE_OSPF6:-no}
export RIPD=${ENABLE_RIP:-no}
export RIPNGD=${ENABLE_RIPNG:-no}
export ISISD=${ENABLE_ISIS:-no}
export PIMD=${ENABLE_PIM:-no}
export PIM6D=${ENABLE_PIM6:-no}
export LDPD=${ENABLE_LDP:-no}
export NHRPD=${ENABLE_NHRP:-no}
export EIGRPD=${ENABLE_EIGRP:-no}
export BABELD=${ENABLE_BABEL:-no}
export SHARPD=${ENABLE_SHARP:-no}
export PBRD=${ENABLE_PBR:-no}
export BFDD=${ENABLE_BFD:-no}
export FABRICD=${ENABLE_FABRIC:-no}
export VRRPD=${ENABLE_VRRP:-no}
export PATHD=${ENABLE_PATH:-no}

envsubst < /etc/frr/daemons.template > /etc/frr/daemons

/usr/lib/frr/docker-start &
sleep 10 # wait for daemons to start (otherwise vtysh may claim no daemons are running)
while :; do
  /usr/bin/vtysh ;
  echo '==> NOPE ! Exiting the shell would also stop the Docker container! Please close the terminal window instead.';
done
