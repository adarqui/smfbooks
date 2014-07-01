#!/bin/bash

if [ $# -ne 4 ] ; then
 echo "usage: ./boot.sh <server_name> <internal_ip> <mysql_root_pw> <mysql_adarq_pw>"
 exit 1
fi

export XSERVER_NAME=$1
export XIP=$2
export XROOT_PW=$3
export XADARQ_PW=$4

# flaccid
sed -e s/"__ip__"/"${XIP}"/g ./boot/node.json.tpl > ./boot/node.json

sed -e s/"__server_name__"/"${XSERVER_NAME}"/g -e s/"__root_password__"/"${XROOT_PW}"/g -e s/"__adarq_password__"/"${XADARQ_PW}"/g ./cookbooks/lxc_smf/templates/default/node.json.tpl > ./cookbooks/lxc_smf/templates/default/node.json

chef-solo -c ./boot/solo.rb -j ./boot/node.json
