#!/bin/sh

if [ ! -f /usr/local/etc/unbound/root.key ]; then
  unbound-anchor
fi

exec /sbin/tini -- unbound -u $UID.$GID -d
