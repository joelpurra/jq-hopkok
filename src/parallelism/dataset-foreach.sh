#!/usr/bin/env bash
set -e

# Execute commands per folder, collecting the output on stdout.
#
# USAGE
# 	"$0" <folder(s)> -- <command(s)>
#	"$0" "folder0" "folder1" "folderN" -- mycommand --option --whatever '{}'
#	"$0" "folder0" "folder1" "folderN" -- echo '"\"This data from the pipe\""' '|' jq --arg folder '{}' --arg pwd '"$PWD"' "'{ folder: \$path, pwd: \$pwd, pipe: . }'"
#
# Separate folder(s) and command(s) with "--".
# Use '{}' in the command to get the folder as input.
# The entire command doesn't have to be a string - everything after '--' will be executed.
# Quote strings used in the command twice; '"string with spaces"'.
# Separate shell commands like semicolon, ampersands and pipe need to be quoted.

folders=()

while [[ "$1" != "--" ]]; do
	folders+=("$1")

	shift
done

shift

command="$@"

parallel --jobs 1 --line-buffer -N 1 cd "--" "{}" "&&" "$command" ::: "${folders[@]}"
