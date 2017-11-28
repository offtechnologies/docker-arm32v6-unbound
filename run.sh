#!/bin/sh

if [ ! -f /etc/unbound/root.key ]; then
  unbound-anchor
fi

chown -R $UID:$GID /var/unbound/ /etc/unbound /tmp

exec /sbin/tini -- unbound -u $UID.$GID -P /tmp/unbound.pid -d
