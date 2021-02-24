# [jq-hopkok](https://github.com/joelpurra/jq-hopkok) [jq](https://stedolan.github.io/jq/) utility library

A bunch of `jq` snippets and shell scripts to manipulate JSON files. See also [`jqnpm`](https://github.com/joelpurra/jqnpm) for `jq` modules/packages.

> [jq](https://stedolan.github.io/jq/) is a lightweight and flexible command-line JSON processor.

---



# Parallel JSON processing utils

Some helpful tools to enable processing JSON data in parallel. This gives significant speedups by utilizing the CPU more aggressively. The speedup is even more noticeable when the data too large to fit in memory, where it would either be impossible to process or be bogged down by virtual memory swapping. Can be used for both data transformations (`map`, mapping) and aggregation (`reduce`, reduction).



## Usage

```bash
# TODO
```



## Explanation

*Originally written as [jq issue #550 "Working with huge data sets - parallelization speed ups, `reduce` with `--slurp`"](https://github.com/stedolan/jq/issues/550), and targets `jq` v1.4.*

For json data in the gigabytes, the key is using [GNU `parallel`](https://www.gnu.org/software/parallel/) for both mapping and reducing. `parallel` helps speeding up the process by utilizing all available CPU cores (by default), and allows for stepwise reductions without running out of RAM.

Assuming a single `input.json` file with separate objects. No separator, but they start and end without indentation.

```json
{
    "a": 1
}
{
    "a": 2
}
```

```bash
parallel --pipe --group --block 10M --recend '\n}\n' jq 'do whatever with each object here'
```

This works great, as `parallel` will make sure that the input is spread objects in 10 megabyte chunks (rounded up to where the nearest object ends with `\n}\n`) to one jq process per CPU core, yet keep the resulting `output.json` grouped (object order doesn't matter to me). I've put the parallelization in a separate script, [`parallel-chunks.sh`](https://github.com/joelpurra/jq-hopkok/blob/master/src/parallelism/parallel-chunks.sh).

```bash
<"input.json" parallel-chunks.sh jq 'some kind of transform' >"output.json"
```

For reductions, I just repeat the process multiple times on 10 megabyte chunks until I only have one object left:

```jq
reduce .[1:][] as $item
(
	.[0];
	# Merge the first object with each of following objects however you like:
	. * $item
)
```

I run the above as `jq --slurp 'reduce ...'`. One example of a simple reduce/merge is the one that recursively adds objects and properties which are numbers, [`reduce-merge-deep-add.sh`](https://github.com/joelpurra/jq-hopkok/blob/master/src/object/reduce-merge-deep-add.sh)

Repeated reductions usage (pseudo-code)

```bash
<"input.json" parallel-chunks.sh reduce-merge-deep-add.sh >"output.tmp.1.json"

while [[ $(getJsonObjectCount "output.tmp.1.json") > 1 ]] do
	<"output.tmp.1.json" parallel-chunks.sh reduce-merge-deep-add.sh >"output.tmp.2.json"
	mv "output.tmp.2.json" "output.tmp.1.json"
}

mv "output.tmp.1.json" "output.json"
```

I use this, in a somewhat more complicated way (cleaning up temp-files, cross-platform counts etcetera) when I prepare (map) and collect aggregate (reduce) numbers from different web pages in [`aggregate/all.sh`](https://github.com/joelpurra/har-dulcify/blob/master/src/aggregate/all.sh). Will try to generalize it later, so you can run something like `repeated-reductions.sh` with any `jq --slurp 'reduce ...'`.

I also use [pipe viewer `pv`](https://www.ivarch.com/programs/pv.shtml) to monitor speed sometimes, but since the output size (usually, otherwise use [`--size`](https://www.ivarch.com/programs/quickref/pv.shtml)) is unknown, it's only a crude indicator on that end.

```bash
pv -cN 'input' "input.json" | parallel-chunks.sh jq 'some transformation' | pv -cN "output" >"output.json"
```

In my case, I have about 100k separate objects in a single file, about six gigabytes in size. I've put them in the same file (at first) to reduce the number of non-sequential disk reads/file lookups, and so I can keep output from each step ([there are many steps](https://github.com/joelpurra/har-dulcify/blob/master/src/one-shot/data.sh)) together as a single file.



---

## License
Copyright (c) 2014, 2015, Joel Purra <https://joelpurra.com/>
All rights reserved.

When using [jq-hopkok](https://github.com/joelpurra/jq-hopkok), comply to at least one of the three available licenses: BSD, MIT, GPL.
Please see the LICENSE file for details.
