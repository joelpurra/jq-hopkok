#!/usr/bin/env bash
set -e

command="$@"

cat | parallel --pipe --group --block 10M --recend '\n}\n' "$command"
