#!/usr/bin/env bash
set -e

# Process two JSON objects (read from stdin) at a time.
# Useful for merging (reduce, reducing, aggregating) two objects at a time.
#
# Input:
#	Each object is expected to be multiline and indented, so that each object ends with a curly brace on a separate line.
#
# Output:
#	The result of the given command on stdout.



command="$@"
recordCount=2

cat | parallel --pipe --group -N "$recordCount" --recend '\n}\n' "$command"
