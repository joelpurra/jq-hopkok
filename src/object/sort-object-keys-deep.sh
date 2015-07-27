#!/usr/bin/env bash
set -e
set -u

# TODO: see if sortObjectKeysRecursively can be replaced by jq command line flag --sort-keys when a newer version of jq is released?
# http://stedolan.github.io/jq/manual/#Invokingjq
# https://github.com/stedolan/jq/issues/169
# Sort the keys in an object by key name, recursively
read -d '' sortObjectKeysRecursively <<"EOF" || true
def sortObjectKeysRecursively:
	if (. | type) == "object" then
		to_entries
		| sort_by(.key)
		| map({
			key,
			value: .value | sortObjectKeysRecursively
		})
		| reverse
		| from_entries
	else
		.
	end;

sortObjectKeysRecursively
EOF

cat - | jq "$sortObjectKeysRecursively"
