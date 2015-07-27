#!/usr/bin/env bash
set -e

read -d '' getStructure <<-'EOF' || true
def replace(a; b):
	split(a)
	| join(b);

def arrayToLookup:
	map(@text)
	| reduce .[] as $exists (
		{};
		. + {
			($exists): null
		}
	);

def lookup(value):
	(value | @text) as $value
	| has($value);

def isWhitelisted(whitelist):
	whitelist as $whitelist
	| explode
	| map(
		. as $charCode
		| $whitelist
		| lookup($charCode)
	)
	| all;

def digitsLookup:
	"0123456789" | explode | arrayToLookup;

def lettersLookup:
	"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" | explode | arrayToLookup;

def specialAlphanumericLookup:
	"_" | explode | arrayToLookup;

def alphanumericLookup:
	digitsLookup + lettersLookup + specialAlphanumericLookup;

def isNumeric:
	isWhitelisted(digitsLookup);

def isAlpha:
	isWhitelisted(lettersLookup);

def isAlphanumeric:
	isWhitelisted(alphanumericLookup);

def isNotValidJsonShorthandPropertyName:
	(.[0:1] | isAlpha | not) or (isAlphanumeric | not);

[
	path(..)
	| map(
		if type == "number" then
			"[]"
		else
			tostring
			| if isNotValidJsonShorthandPropertyName then
				"[\\"\\(.)\\"]"
			else
				.
			end
		end
	)
	| join(".")
	| replace(".["; "[")
]
| unique
| map("." + .)
| .[]
EOF

cat | jq --raw-output "$getStructure"
