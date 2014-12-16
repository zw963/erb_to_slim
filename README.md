# ErbToSlim [![Build Status](https://travis-ci.org/zw963/erb_to_slim.svg?branch=master)](https://travis-ci.org/zw963/erb_to_slim) [![Gem Version](https://badge.fury.io/rb/erb_to_slim.svg)](http://badge.fury.io/rb/erb_to_slim)

The most stupid ERB to Slim Converter.

## Philosophy

Convert `html.erb` to `html.slim` directly with REGEXP.

  * Minimum modified, no indentation or outline changed.
  * No any gem dependency, YEAH!
  
## Getting Started

Install via Rubygems

    $ gem install erb_to_slim

OR ...

Add to your Gemfile

    gem 'erb_to_slim'

## Usage

Goto your's project views directory.

    $ erb_to_slim

This will convert all `*.html.erb` to `*.html.slim` under current directory recursively.
old file will backup as `*.html.erb.bak`.

## Support

  * MRI 1.9+
  * Rubinius 2.2+

You need Ruby 1.9+ to support the newest regular expression syntax.

## Limitations
  * Only support html.erb format.
  * This gem just do match and replace with REGEXP, not do any syntactic analysis or
    indent detection, so, before process, please format ERB file with your's favorate editor.
  * This gem is not test fully, consider all cases is not possible.
    So, before you try, ensure about you well understood Slim,
    and can fix any unexpected error manually.
  
## History

  See [CHANGELOG](https://github.com/zw963/erb_to_slim/blob/master/CHANGELOG) for details.

## Contributing

  * [Bug reports](https://github.com/zw963/erb_to_slim/issues)
  * [Source](https://github.com/zw963/erb_to_slim)
  * Patches:
    * Fork on Github.
    * Run `gem install --dev erb_to_slim` or `bundle`.
    * Create your feature branch: `git checkout -b my-new-feature`.
    * Commit your changes: `git commit -am 'Add some feature'`.
    * Push to the branch: `git push origin my-new-feature`.
    * Send a pull request :D.

## license

Released under the MIT license, See [LICENSE](https://github.com/zw963/erb_to_slim/blob/master/LICENSE) for details.
