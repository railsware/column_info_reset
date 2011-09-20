# Column Info Reset

Simple gem that reset ActiveRecord column information when 

    Unknown column 'bla' in 'field list'

exception occurs.

This gem allows you safely run migrations that to drop **unused** table columns.

## Installation

    gem install column_info_reset

## Tests

Run all tests against two active records versions:

    script/test

### ActiveRecord v1.x.x

    rvm install ruby-1.8.6
    script/bundle-ar1 install
    script/bundle-ar1 exec spec -fs -c spec

### ActiveRecord v3.x.x

    rvm install ruby-1.9.2
    script/bundle-ar3 install
    script/bundle-ar3 exec spec -fs -c spec
