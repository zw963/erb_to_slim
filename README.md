# ErbToSlim [![Build Status](https://travis-ci.org/zw963/erb_to_slim.svg?branch=master)](https://travis-ci.org/zw963/erb_to_slim)


The most stupid ERB to Slim Converter.

## Usage
```sh
$ gem install erb_to_slim
```

Goto ERB template directory:

```sh
$ erb_to_slim
```

It will convert all `*.html.erb` files in current directory and subdirectory to `*.html.slim`, 
and rename original file to `*.html.erb.bak`.

## How it works

[ERbToSlim](https://github.com/zw963/erb_to_slim) convert ERB to Slim directly with REGEXP.
You need Ruby 1.9+ to support the newest regular expression syntax.

## Feature
* Minimum modified, not change indentation/outline.
* No any gem dependency, YEAH!

## Limitations
* Only support html.erb format.
* This gem just do match and replace with REGEXP, not do any syntactic analysis or
  indent detection, so, before process, please format ERB file with your's favorate editor.
* This gem is not test fully, consider all cases is not possible.
  So, before you try, ensure about you well understood Slim,
  and can fix any unexpected error manually.

## Author

Billy.zheng (zw963)

## OFFICIAL REPO
https://github.com/zw963/erb_to_slim

## Contact
If you found any bug, please file an issue at [github](https://github.com/zw963/erb_to_slim/issues).

