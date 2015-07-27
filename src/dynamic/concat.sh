#!/usr/bin/env bash
set -e

# Concatenate values from multiple JSON files, read from stdin.

jq --slurp --online-input '.'