# Webern

Transforms user input into a complete 12-tone row and computes all 48 (at most) possible rows that result from the matrix of that row.

## Installation

Add this line to your application's Gemfile:

    gem 'webern'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webern

## Usage

Create a row of the numbers 0 - 11

    row = Webern::Row.new(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)

You do not need to provide a full row. `Webern` will fill out the missing
numbers by adding them in ascending order to the end of the provided row.

    row = Webern::Row.new(5, 4, 8, 7, 10, 11, 3, 2) #=> [5, 4, 8, 7, 10, 11, 3, 2, 0, 1, 6, 9]

Your row can then be printed as a text or PDF matrix, or a lilypond score
with all possible rows printed

    row.print(format, options)

where `format` can currently be one of

* `:text`
* `:pdf`
* `:lilypond`

and allowed `options` are

* `:show_pitches` (defaults to `true`) 
  * if `true`, outputs text and PDF
formats using pitch class names (C, C#, D, Eb, etc.)
  * if `false`, outputs text and PDF using scale degrees (0, 1, 2, 3, etc.)
* `:filename` (defaults to `row`)
* `:path` (defaults to current directory)

`Webern` can also print a text matrix directly to the console with

  row.draw(options)

where `options` are the same as above (though only `:show_pitches` will affect the output)


The `lilypond` executable is required in order to convert the resulting `filename.ly` file to PDF.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright © 2013 Michael Berkowitz (@hal678). See LICENSE.txt for further details. 
