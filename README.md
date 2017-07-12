# webern (0.1.0)

Elixir library for creating and working with 12-tone rows

![](config/Webern.jpg)

## API

### Creating objects

`Webern.row/1` provides a helper function to generate a new tone row consisting
of pitch classes from the 12-tone semitone chromatic scale

`Webern.matrix/1` accepts a row as an argument and returns a displayable matrix
based on the row.

### Transforming tone rows

`Webern` also provides functions for the standard serial transformations:

* `prime` - the original form of the row

* `retrograde` - the row backwards

  * if the prime form begins with pitch class indices [3, 5], the retrograde
    form will end with pitch class indices [5, 3]

* `inverse` - the row with the interval between each set of pitch classes
  flipped

  * if the first two pitch classes in the prime form of the row are [3, 5],
    the first two pitch classes of the inverse form will be [3, 1];
    the upward step of 2 semitones becomes a downward step of 2 semitones

* `retrograde_inverse` - a compound transformation, acheived by taking first
  the inverse of the prime form, and then the retrograde of the resulting
  form

* `inverse_retrograde` - another, less common compound form, acheived by
  taking first the retrograde of the prime form, and then the inverse of
  the resulting form

For more information about twelve tone technique and transformations, see
[Twelve-tone technique](https://en.wikipedia.org/wiki/Twelve-tone_technique)
on Wikipedia

### Output

Both `Webern.Row` and `Webern.Matrix` implement the `String.Chars` protocol:

  ```elixir
  iex> row = Webern.row([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
  iex> to_string(row)
  "c   d   cs  ef  e   fs  f   g   af  bf  a   b"

  iex> matrix = Webern.matrix(row)
  iex> to_string(matrix)
  "c   d   cs  ef  e   fs  f   g   af  bf  a   b
  bf  c   b   cs  d   e   ef  f   fs  af  g   a
  ...
  cs  ef  d   e   f   g   fs  af  a   b   bf  c"

  ```

`Webern.Row.to_list/2` allows for more customized output of a row's contents.
Passing only the row to `to_list/2` will return the pitch classes as integers

  ```elixir
  iex> row = Webern.row([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
  iex> Webern.Row.to_list(row)
  [0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11]
  ```

Passing the option `to_pitches: true` will convert the pitch classes to their
lilypond formatted pitch class names, with 0 == `c`

  ```elixir
  iex> row = Webern.row([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
  iex> Webern.Row.to_list(row, to_pitches: true)
  ["c", "d", "cs", "ef", "e", "f", "fs", "f", "g", "af", "bf", "a", "b"]
  ```

Passing a pitch class name as the option `zero_pitch` works as above, but will
set 0 == `zero_pitch`

  ```elixir
  iex> row = Webern.row([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
  iex> Webern.Row.to_list(row, to_pitches: true, zero_pitch: "fs")
  ["fs", "af", "g", "a", "bf", "b", "c", "b", "cs", "d", "e", "ef", "f"]
  ```

`Webern` provides the `Webern.Lilypond` protocol and its `to_lily/1` function.
This function embeds a valid [LilyPond](http://www.lilypond.org) represenation of the row or matrix inside
a full lilypond document string. For a row, this returns a result almost identical
to calling `to_string/1` on the row (the only change being octave markings for
the pitch classes). For a matrix, the document will contain 60 rows, each of the
five row transformations listed above for each chromatic semitone.

While `Webern.Lilypond.to_lily/1` can be called on its own to return the LilyPond
document string, `Webern.to_lily/2` exists, which writes that document to a file
(whose name is passed as the second argument) and compiles it to a PDF document,
provided LilyPond is installed on your system.

  ```elixir
  iex> row = Webern.row([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
  iex> Webern.to_lily(row, "my_row")
  :ok #=> this creates `my_row.ly` and `my_row.pdf` in your current working directory
  ```

## Installation

1. Add webern to your `mix.exs` dependencies

    ```elixir
    defp deps do
      [ {:webern, "~> 0.1"} ]
    end
    ```

2. Run `mix do deps.get, compile`

### Dependencies

Most of `Webern`'s functionality requires only an Elixir installation, but if
you wish to use the `Webern.to_lily/2` function provided, make sure LilyPond
is installed on your system using the links and instructions found
[here](http://lilypond.org/download.html).
