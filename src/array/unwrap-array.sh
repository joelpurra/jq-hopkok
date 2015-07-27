#!/usr/bin/env bash
set -e
set -u

# Extract values from an array, with a line break between each value.

jq --unbuffered '.[]'
