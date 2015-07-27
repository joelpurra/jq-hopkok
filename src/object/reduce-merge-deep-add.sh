#!/usr/bin/env bash
set -e

# Apply the addition (+) operator to a deep JSON object structure.
#
# Input:
#	A file with objects, preferably similar in structure. The first object will become the base (left) object, further objects will be added to it (right).
#
# Output:
# 	Adds numbers, concatenate arrays, join strings and merge objects. Operations add the right object to the left.
#
# https://stedolan.github.io/jq/manual/#Builtinoperatorsandfunctions

read -d '' reduceMerge <<-'EOF' || true
def deepAdd(item):
	item as $item
	| with_entries(
		($item[.key]) as $other
		| if (.value | type) == "number" and ($other | type) == "number" then
			.value += $other
		else
			.value |= deepAdd($other)
		end
	);

reduce .[1:][] as $halfway
(
	.[0];
	deepAdd($halfway)
)
EOF

cat | jq --slurp "$reduceMerge"
