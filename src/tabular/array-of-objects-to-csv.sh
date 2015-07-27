#!/usr/bin/env bash
set -e

# Convert an array of objects to CSV format.
# https://en.wikipedia.org/wiki/Comma-separated_values
#
# The object keys are used as column headers.
#
# Input:
#	An array of JSON objects (from stdin) which have the same, flat structure of keys/values.
# Output:
#	Text formatted as CSV.


read -d '' getCSV <<-'EOF' || true
def objectAsCsv(keyOrValue):
	to_entries
	| map(
		keyOrValue
	)
	| @csv;

def toHeader:
	objectAsCsv(.key);

def toLine:
	objectAsCsv(.value);

def toLines:
	map(toLine)
	| join("\\r\\n");

(.[0] | toHeader),
toLines
EOF

cat | jq --raw-output "$getCSV"
