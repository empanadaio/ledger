#!/bin/bash

if [[ "$1" != "blue" && "$1" != "green" ]]
then
  echo "promote blue or promote green"
  exit 1
fi

ln -snf "$1_upstream.conf" nginx/active_upstream.conf

kill -HUP `cat nginx/nginx.pid`
