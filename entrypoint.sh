#!/usr/bin/env bash

if [ -z "$SSHUSER_AUTH_KEYS" ]; then
  echo "Environment variable SSHUSER_AUTH_KEYS is empty. Aborting."
  exit 1
fi

if [ -f /home/sshuser/.ssh/authorized_keys ]; then
  rm -f /home/sshuser/.ssh/authorized_keys
fi

touch /home/sshuser/.ssh/authorized_keys

echo "Adding authorized_keys ..."

COUNT=0
IFS=","
for key in $SSHUSER_AUTH_KEYS; do
  echo "$key" >> /home/sshuser/.ssh/authorized_keys
  let COUNT=COUNT+1
done

echo "Added $COUNT keys"

ssh-keygen -A

exec /usr/sbin/sshd -e -D "$@"
