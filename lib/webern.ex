defmodule Webern do
  @moduledoc """
  Main entrypoint into the `Webern` functionality.

  ## Creating objects

  `row/1` provides a helper function to generate a new tone row consisting
  of pitch classes from the 12-tone semitone chromatic scale

  `matrix/1` accepts a row as an argument and returns a displayable matrix
  based on the row.

  ## Transforming tone rows

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
  """

  alias Webern.{Row, Matrix, Lilypond}

  @type row :: Row.t
  @type matrix :: Matrix.t

  @doc """
  Create a `Webern.Row` from the provided `source_row`.

  The input `source_row` should be a 12-tone row defined by an ordering of
  the integers `0`..`11`.

  A shorter row can also be supplied, but the modulo
  point of the generated row will still be 12, allowing the possibility for
  row permutations to include pitches not present in the original row.
  """
  @spec row([integer]) :: row
  def row(source_row) when is_list(source_row) do
    Row.new(source_row)
  end

  @doc """
  Returns the prime form of `row`, optionally transposed
  to begin at pitch class `start`.

  ## Example

      iex> row = Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      iex> Webern.prime(row)
      %Webern.Row{
        pitch_classes: [0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11]
      }
      iex> Webern.prime(row, 3)
      %Webern.Row{
        pitch_classes: [3, 5, 4, 6, 7, 9, 8, 10, 11, 1, 0, 2]
      }

  See [above](#module-transforming-tone-rows) for details about the prime form
  """
  @spec prime(row, integer | nil) :: row
  def prime(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.prime(row, start)
    end
  end

  @doc """
  Returns the retrograde form of `row`, with the prime form optionally
  transposed to begin at pitch class `start`.

      iex> row = Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      iex> Webern.retrograde(row)
      %Webern.Row{
        pitch_classes: [11, 9, 10, 8, 7, 5, 6, 4, 3, 1, 2, 0]
      }
      iex> Webern.retrograde(row, 4)
      %Webern.Row{
        pitch_classes: [3, 1, 2, 0, 11, 9, 10, 8, 7, 5, 6, 4]
      }

  See [above](#module-transforming-tone-rows) for details about
  the retrograde form
  """
  @spec retrograde(row, integer | nil) :: row
  def retrograde(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.retrograde(row, start)
    end
  end

  @doc """
  Returns the inverse form of `row`, optionally transposed
  to begin at pitch class `start`.

      iex> row = Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      iex> Webern.inverse(row)
      %Webern.Row{
        pitch_classes: [0, 10, 11, 9, 8, 6, 7, 5, 4, 2, 3, 1]
      }
      iex> Webern.inverse(row, 1)
      %Webern.Row{
        pitch_classes: [1, 11, 0, 10, 9, 7, 8, 6, 5, 3, 4, 2]
      }

  See [above](#module-transforming-tone-rows) for details about the inverse
  form
  """
  @spec inverse(row, integer | nil) :: row
  def inverse(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.inverse(row, start)
    end
  end

  @doc """
  Returns the retrograde inverse form of `row`, with the prime form optionally
  transposed to begin at pitch class `start`.

  ## Example

      iex> row = Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      iex> Webern.retrograde_inverse(row)
      %Webern.Row{
        pitch_classes: [1, 3, 2, 4, 5, 7, 6, 8, 9, 11, 10, 0]
      }
      iex> Webern.retrograde_inverse(row, 5)
      %Webern.Row{
        pitch_classes: [6, 8, 7, 9, 10, 0, 11, 1, 2, 4, 3, 5]
      }

  See [above](#module-transforming-tone-rows) for details about the retrograde
  inverse form
  """
  @spec retrograde_inverse(row, integer | nil) :: row
  def retrograde_inverse(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.retrograde_inverse(row, start)
    end
  end

  @doc """
  Returns the inverse retrograde form of `row`, with the prime form optionally
  transposed to begin at pitch class `start`.

  ## Example

      iex> row = Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      iex> Webern.inverse_retrograde(row)
      %Webern.Row{
        pitch_classes: [11, 1, 0, 2, 3, 5, 4, 6, 7, 9, 8, 10]
      }
      iex> Webern.inverse_retrograde(row, 8)
      %Webern.Row{
        pitch_classes: [7, 9, 8, 10, 11, 1, 0, 2, 3, 5, 4, 6]
      }

  See [above](#module-transforming-tone-rows) for details about the inverse
  retrograde form
  """
  @spec inverse_retrograde(row, integer | nil) :: row
  def inverse_retrograde(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.inverse_retrograde(row, start)
    end
  end

  @doc """
  Returns a tone row matrix using `row` as the initial prime form.
  """
  @spec matrix(row) :: matrix
  def matrix(row = %Webern.Row{}) do
    Matrix.new(row)
  end

  @doc """
  Generates lilypond and PDF files for the given row or matrix.

  This function wraps `Webern.Lilypond.to_lily/1`, writing the content
  that functions generates a lilypond file in your current working directory
  and compiles it to a PDF file.
  """
  @spec to_lily(row | matrix, String.t) :: charlist
  def to_lily(object, filename) do
    with  full_filename <- filename <> ".ly",
          :ok <- File.write(full_filename, Lilypond.to_lily(object))
    do
      "lilypond -o #{filename} #{full_filename}"
      |> to_charlist |> :os.cmd
    end
  end
end
