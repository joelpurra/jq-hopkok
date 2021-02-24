# [jq-hopkok](https://github.com/joelpurra/jq-hopkok) [jq](https://stedolan.github.io/jq/) utility library

A bunch of `jq` snippets and shell scripts to manipulate JSON files. See also [`jqnpm`](https://github.com/joelpurra/jqnpm) for `jq` modules/packages.

> [jq](https://stedolan.github.io/jq/) is a lightweight and flexible command-line JSON processor.

---



# JSON-to-tabular utils

Useful tools to convert from JSON to [comma-separated values (CSV)](https://en.wikipedia.org/wiki/Comma-separated_values) or [tab-separated values (TSV)](https://en.wikipedia.org/wiki/Tab-separated_values) used as tabular (spreadsheet, database) data.



## Usage

```bash
# TODO
```



## Explanation

*Originally written as a comment in [jq issue #48 "tsv and/or csv output support"](https://github.com/stedolan/jq/issues/48#issuecomment-55744660), and targets `jq` v1.4.*

For reference: RFC4180, Common Format and MIME Type for Comma-Separated Values (CSV) Files
https://www.ietf.org/rfc/rfc4180.txt

I use two scripts I pipe JSON into, and get CSV/TSV output. Object keys are used to generate a header.
https://github.com/joelpurra/jq-hopkok/blob/master/src/tabular/array-of-objects-to-csv.sh
https://github.com/joelpurra/jq-hopkok/blob/master/src/tabular/array-of-objects-to-tsv.sh

Because of implementation details in `to_entries` (see https://github.com/stedolan/jq/issues/561 [`to_entries` always outputs keys sorted - can it be avoided?](https://github.com/stedolan/jq/issues/561)), I have to name keys so they're sorted in the output. I follow the format `01--My first column`, `02--My second column`, `03--A third column`, and clean them with another script.
https://github.com/joelpurra/jq-hopkok/blob/master/src/tabular/clean-csv-sorted-header.sh
https://github.com/joelpurra/jq-hopkok/blob/master/src/tabular/clean-tsv-sorted-header.sh


```json
[
	{
		"01--Employee name": "Homer Simpson",
		"02--Logins": 578
	},
	{
		"01--Employee name": "Carl Carlsson",
		"02--Logins": 75926
	}
]
```

```bash
<"input.json" array-of-objects-to-tsv.sh | clean-tsv-sorted-header.sh >"output.json"
```

```tsv
Employee name	Logins
Homer Simpson	578
Carl Carlsson	75926
```

The same input piped through the CSV scripts produces this.

```csv
"Employee name","Logins"
"Homer Simpson",578
"Carl Carlsson",75926
```

I prefer TSV as it's much easier to split the raw data into columns (some tex/latex packages don't play nice with RFC4180 input). I've taken a shortcut in replacing  `\t` in strings with `\\t` - in my own data I "assume" there are no tabs in the output.

Hope these scripts can help someone.



---

## License
Copyright (c) 2014, 2015, Joel Purra <https://joelpurra.com/>
All rights reserved.

When using [jq-hopkok](https://github.com/joelpurra/jq-hopkok), comply to at least one of the three available licenses: BSD, MIT, GPL.
Please see the LICENSE file for details.
