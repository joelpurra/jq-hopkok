#!/usr/bin/env bash
set -e

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
