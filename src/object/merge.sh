#!/usr/bin/env bash
set -e
set -u

jq --slurp add "$@"
