#!/usr/bin/env bash
set -e

# Assemble a URL string from an object with the URL components.

read -d '' fromComponents <<-'EOF' || true
def joinUrlComponents:
	(
		""
		+ (if (.scheme and .scheme.valid) then .scheme.value else "" end)
		+ ":"
		+ "//"
		+ (if (.domain and .domain.valid) then .domain.value else "" end)
		+ (if (.port and .port.valid and .port.separator) then (":" + if ((.port.value | type) != "null") then (.port.value | tostring) else "" end) else "" end)
		+ (if (.path and .path.valid) then .path.value else "" end)
		+ (if (.query and .query.valid and .query.separator) then ("?" + if ((.query.value | type) != "null") then .query.value else "" end) else "" end)
		+ (if (.fragment and .fragment.valid and .fragment.separator) then ("#" + if ((.fragment.value | type) != "null") then .fragment.value else "" end) else "" end)
	);

joinUrlComponents
EOF

cat | jq "$fromComponents"
