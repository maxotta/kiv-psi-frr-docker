#!/bin/sh

# Set which daemons to start based on environment variables (with 'no' defaults)
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

# We must store the FRR configuration files in a persistent location, so they are not lost
# when the container is removed. We use /etc/network/frr for that purpose.
# Moreover, the /etc/network directory of each container is also included in the project's archive,
# when exporting the project using the "Export portable project" feature of the GNS3 GUI.

# Check if /etc/network/frr persistent configuration directory exists
if [ ! -d /etc/network/frr ] && [ ! -L /etc/frr ] ; then
# If not, create /etc/network/frr and a symbolic link from /etc/frr to it.
  mkdir /etc/network/frr
  ln -s /etc/network/frr /etc/frr
fi

# Create vtysh.conf and integrated /etc/frr/frr.conf if it does not exist. Empty is OK
touch /etc/frr/vtysh.conf
touch /etc/frr/frr.conf
chown frr:frr /etc/frr/*

# Generate the /etc/frr/daemons file from the template
envsubst < /usr/lib/frr/daemons.template > /etc/frr/daemons

/usr/lib/frr/docker-start &
sleep 10 # wait for daemons to start (otherwise vtysh may claim no daemons are running)
while :; do
  /usr/bin/vtysh ;
  echo '==> NOPE ! Exiting the shell would also stop the Docker container! Please close the terminal window instead.';
done

# EOF
