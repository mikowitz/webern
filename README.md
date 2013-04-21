# Webern

Transforms user input into a complete 12-tone row and computes all 48 (at most) possible rows that result from the matrix of that row.

Possible outputs:

* text
* pdf
* lilypond

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

Then choose a format in which to output either the matrix (text or pdf) or all
possible rows resulting from that matrix (lilypond).

    Webern::Formatters.Text.new(row).print_to_file('filename.txt)
    Webern::Formatters.Pdf.new(row).print_to_file('filename.pdf)
    Webern::Formatters.Lilypond.new(row).print_to_file('filename.ly')

The `lilypond` executable is required in order to convert the resulting `filename.ly` file to PDF.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
