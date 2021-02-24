# [jq-hopkok](https://github.com/joelpurra/jq-hopkok) [jq](https://stedolan.github.io/jq/) utility library

A bunch of `jq` snippets and shell scripts to manipulate JSON files. See also [`jqnpm`](https://github.com/joelpurra/jqnpm) for `jq` modules/packages.

> [jq](https://stedolan.github.io/jq/) is a lightweight and flexible command-line JSON processor.

---



# JSON URL utils

Useful for manipulating a URL as an object with individual components instead of a complex string.



## Usage

```shell
# URL to components
echo '"https://server.example.com/deep/path/file.ext?with-a-parameter=true#and-a-fragment"' | ./to-components.sh

# Join components to a URL
echo '"https://server.example.com/deep/path/file.ext?with-a-parameter=true#and-a-fragment"' | ./to-components.sh | ./from-components.sh
```



---

## License
Copyright (c) 2014, 2015, Joel Purra <https://joelpurra.com/>
All rights reserved.

When using [jq-hopkok](https://github.com/joelpurra/jq-hopkok), comply to at least one of the three available licenses: BSD, MIT, GPL.
Please see the LICENSE file for details.
