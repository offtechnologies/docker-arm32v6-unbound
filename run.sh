#!/bin/sh

if [ ! -f /usr/local/etc/unbound/root.key ]; then
  unbound-anchor
fi

chown -R unbound:unbound /usr/local/etc/unbound/

exec /sbin/tini -- unbound -c /usr/local/etc/unbound/unbound.conf -d -v
