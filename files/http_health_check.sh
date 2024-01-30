#!/bin/bash

base_url=$1

status_code=$(curl -I -s ${base_url} | grep -w HTTP | cut -d " " -f2)

if [[ $status_code == "200" ]]; then
    exit 0
else
    exit 1
fi
