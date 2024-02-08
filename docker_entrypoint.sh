#!/bin/bash

set -e

export HOST_IP=$(ip -4 route list match 0/0 | awk '{print $3}')
export CASCDR_VENDOR_CONFIG_PATH=/root

echo start9/public > /root/.backupignore
echo start9/shared >> /root/.backupignore

yq e '.tor-address' /root/start9/config.yaml
yq e '.lan-address' /root/start9/config.yaml

result=$(yq '.nodes.[] | select(.connection-settings.type == "internal" and .type == "lnd")' /root/start9/config.yaml)
if [[ ! -z $result ]]
  then

  if ! test -d /mnt/lnd
  then
    echo "LND mountpoint does not exist"
    exit 0
  fi

  while ! test -f /mnt/lnd/admin.macaroon
  do
    echo "Waiting for LND admin macaroon to be generated..."
    sleep 1
  done
fi

# result=$(yq '.nodes.[] | select(.connection-settings.type == "internal" and .type == "c-lightning")' /root/start9/config.yaml)
# if [[ ! -z $result ]]
#   then

#   if ! test -d /mnt/c-lightning
#   then
#     echo "Core Lightning mountpoint does not exist"
#     exit 0
#   fi

#   while ! test -f /mnt/c-lightning/access.macaroon
#   do
#     echo "Waiting for c-Lightning-REST access macaroon to be generated..."
#     sleep 1
#   done
# fi

exec tini -g -- bun cascdr-vendor
