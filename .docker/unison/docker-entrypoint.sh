#!/bin/bash

if [[ $SYNC_DESTINATION == "ssh://"* ]]; then
  # Destination is ssh based so wait for ssh key pair.
  while [ ! -e ~/.ssh/id_rsa ];do
    echo -e "\nSync destination uses ssh, waiting for ssh keys in ~/.ssh directory. Sleeping for 5 seconds."
    sleep 5
  done
fi

exec "$@"
