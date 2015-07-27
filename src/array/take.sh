#!/usr/bin/env bash
set -e

if [[ $# == 2 ]]
then
	takeNumStart="$1"
	takeNumEnd="$2"
elif [[ $# == 1 ]]; then
	takeNumStart=""
	takeNumEnd="$1"
	if [[ $takeNumEnd == 0 ]]; then
		exit 0
	fi
	if [[ $takeNumEnd -le 0 ]]; then
		takeNumStart="$1"
		takeNumEnd=""
	fi
else
	echo "Return elements from a JSON array read from stdin. Count is natural. Start and end zero-based indices. Start is inclusive, end is not. Negative numbers means taking from the end of the array."
	echo "Usage: "
	echo "    ${BASH_SOURCE##*/} [count]"
	echo "    ${BASH_SOURCE##*/} [start] [end]"
	exit 1
fi

cat | jq ".[$takeNumStart:$takeNumEnd]"
