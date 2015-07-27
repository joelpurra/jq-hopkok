#!/usr/bin/env bash
set -e

# Clean up TSV headers which start with a sortable number sequence; 00--OneColumn	01--AnotherColumn

cat | sed -e '1s/^[[:digit:]][[:digit:]][[:digit:]]*--//g' -e '1s/	[[:digit:]][[:digit:]][[:digit:]]*--/	/g'
