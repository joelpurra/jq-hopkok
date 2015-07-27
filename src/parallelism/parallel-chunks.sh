#!/usr/bin/env bash
set -e

# Process JSON objects (read from stdin) in 10 megabyte chunks.
# Useful when input is too large to fit in memory, or to speed up processing in general.
#
# Input:
#	Each object is expected to be multiline and indented, so that each object ends with a curly brace on a separate line.
#
# Output:
#	The result of the given command on stdout.

command="$@"

cat | parallel --pipe --group --block 10M --recend '\n}\n' "$command"
