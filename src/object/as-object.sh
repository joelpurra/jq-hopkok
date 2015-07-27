#!/usr/bin/env bash
set -e
set -u

key="$1"
shift

echo "{ \"${key}\": $(cat -) }"
