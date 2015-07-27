#!/usr/bin/env bash
set -e

command="$@"
recordCount=2

cat | parallel --pipe --group -N "$recordCount" --recend '\n}\n' "$command"
