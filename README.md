# [jq-hopkok](http://joelpurra.github.com/jq-hopkok) [jq](https://stedolan.github.io/jq/) library

A bunch of jq snippets to manipulate json files, collected from other projects, for example [har-dulcify](https://github.com/joelpurra/har-dulcify), [har-heedless](https://github.com/joelpurra/har-heedless) and [ep-erroneous-votes](https://github.com/joelpurra/ep-erroneous-votes).

> [jq](https://stedolan.github.io/jq/) is a lightweight and flexible command-line JSON processor.



## Get it

Until there's a jq package manager, just clone the repository.

```
git clone --recursive git://github.com/joelpurra/jq-hopkok.git
```



## Usage

Also see each source file, but don't expect much documentation yet.

```shell
# URL to components
echo '"https://server.example.com/deep/path/file.ext?with-a-parameter=true#and-a-fragment"' | ./to-components.sh

# Join components to a URL
echo '"https://server.example.com/deep/path/file.ext?with-a-parameter=true#and-a-fragment"' | ./to-components.sh | ./from-components.sh
```



## Original purpose

The library was built awaiting and expecting a jq package system. I hope this will become a proper first-generation package.



## Dependencies

jq-hopkok's runtime dependencies are

* [jq](https://stedolan.github.io/jq/) 1.4+
* [bash](https://www.gnu.org/software/bash/) 4+


## TODO

*Patches/pull requests welcome!*

* Write tests.
* Break out jq scripts from shell scripts.
* Split up files into smaller parts.



## License
Copyright (c) 2014, Joel Purra <http://joelpurra.com/>
All rights reserved.

When using jq-hopkok, comply to at least one of the three available licenses: BSD, MIT, GPL.
Please see the LICENSE file for details.


