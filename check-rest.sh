#!/bin/bash

DURATION=$(</dev/stdin)
if (($DURATION <= 30000 )); then 
    exit 60
else
    curl --silent cascdr.embassy:3003/x/get_result &>/dev/null
    exit_code=$?
    if test "$exit_code" != 0; then
        echo "The cascdr-vendor REST API is unreachable" >&2
        exit 1
    fi
fi
