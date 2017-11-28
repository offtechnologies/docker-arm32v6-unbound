#!/bin/sh

if [ ! -f /usr/local/etc/unbound/root.key ]; then
  unbound-anchor
fi

exec /sbin/tini -- unbound -c /usr/local/etc/unbound/unbound.conf -d -v
