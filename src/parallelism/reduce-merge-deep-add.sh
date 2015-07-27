#!/usr/bin/env bash
set -e

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
