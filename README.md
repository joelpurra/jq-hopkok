# [jq-hopkok](https://github.com/joelpurra/jq-hopkok) [jq](https://stedolan.github.io/jq/) utility library

A bunch of `jq` snippets and shell scripts to manipulate JSON files. See also [`jqnpm`](https://github.com/joelpurra/jqnpm) for `jq` modules/packages.

> [jq](https://stedolan.github.io/jq/) is a lightweight and flexible command-line JSON processor.

---



## Get it

Just clone the repository.

```
git clone --recursive git://github.com/joelpurra/jq-hopkok.git
```



## Usage

See `README.md` each folder, as well as source files. Don't expect much documentation yet.


```text
$ tree src
src
├── array
│   ├── README.md
│   ├── take.sh
│   ├── to-array.sh
│   └── unwrap-array.sh
├── dynamic
│   ├── README.md
│   └── concat.sh
├── metadata
│   ├── README.md
│   └── structure.sh
├── object
│   ├── README.md
│   ├── as-object.sh
│   ├── merge.sh
│   ├── reduce-merge-deep-add.sh
│   └── sort-object-keys-deep.sh
├── parallelism
│   ├── README.md
│   ├── dataset-foreach.sh
│   ├── dataset-query.sh
│   ├── parallel-chunks.sh
│   └── parallel-n-2.sh
├── tabular
│   ├── README.md
│   ├── array-of-objects-to-csv.sh
│   ├── array-of-objects-to-tsv.sh
│   ├── clean-csv-sorted-header.sh
│   └── clean-tsv-sorted-header.sh
└── url
    ├── README.md
    ├── from-components.sh
    └── to-components.sh

7 directories, 26 files
```



## Original purpose

The library was built awaiting a jq module/package system, but also to collect shell utils for JSON manipulation. Some of these utils can be converted to packages, while others rely on external programs such as the `bash` shell.



## Dependencies

Most utils were written for jq v1.4, and some can be probably be significantly improved with v1.5+ features. When the time comes, the plan is to maintain a branch per jq version for backwards compatibility.

jq-hopkok's runtime dependencies:

- [`jq`](https://stedolan.github.io/jq/) v1.4+
- [`bash`](https://www.gnu.org/software/bash/) v4+

Some utils also use:

- [GNU `parallel`](https://www.gnu.org/software/parallel/)



## See also

- [`jqnpm`](https://github.com/joelpurra/jqnpm) for `jq` modules/packages.
- The [`jq` wiki](https://github.com/stedolan/jq/wiki)'s [cookbook](https://github.com/stedolan/jq/wiki/Cookbook) for examples and smart solutions.
- [har-dulcify](https://github.com/joelpurra/har-dulcify) for the origin of some utils, as well as example usage -- especially of the parallelism utils.
- [ep-erroneous-votes](https://github.com/joelpurra/ep-erroneous-votes) for the origin of some utils, and example usage.


## TODO

*Patches/pull requests welcome!*

- Write tests.
- Break out jq scripts from shell scripts.
- Split up files into smaller parts.



---

## License
Copyright (c) 2014, 2015, Joel Purra <http://joelpurra.com/>
All rights reserved.

When using [jq-hopkok](https://github.com/joelpurra/jq-hopkok), comply to at least one of the three available licenses: BSD, MIT, GPL.
Please see the LICENSE file for details.
