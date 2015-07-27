#!/usr/bin/env bash
set -e

read -d '' getTSV <<-'EOF' || true
def replace(a; b):
	split(a)
	| join(b);

def tsvFormattedValue:
	type as $type
	| if (["number", "boolean", "null"] | map(. == $type) | any) then
		.
	else
		@text
		| replace("\\t"; "\\\\t")
		# Not quoting, as I hope visualizing/escaping the tabs will be enough for this hack.
		#| "\\"" + . + "\\""
	end;

def tsvFormattedLine:
	map(
		@text
	)
	| join("\\t");

def objectAsTsv(keyOrValue):
	to_entries
	| map(
		keyOrValue
		| tsvFormattedValue
	)
	| tsvFormattedLine;

def toHeader:
	objectAsTsv(.key);

def toLine:
	objectAsTsv(.value);

def toLines:
	map(toLine)
	| join("\\n");

(.[0] | toHeader),
toLines
EOF

cat | jq --raw-output "$getTSV"
