defmodule Webern.Matrix do
  @moduledoc """
  Models a matrix built from a `Webern.Row`

  N.B. Although the main functionality for matrix creation is
  defined in this module, the `Webern` module provides a more user-friendly
  interface, and it is recommended to use the functions defined there for
  your own work.

  ### `to_string/1`

  The `Webern.Matrix` implementation of the `Strings.Char` protocol maps
  `to_string/1` over the ordered prime rows of the matrix and joins them
  together with new lines. See `Webern.Row` for details.

  ### `to_lily/1`

  The `Webern.Matrix` implementation of `Webern.Lilypond` embeds all 60
  possible transformations of the original row (primes, retrogrades, inverses,
  retrograde inverses, and inverse retrogrades), each labeled, into a
  Lilypond document that can be saved to a file and compiled.

  """

  alias Webern.Row

  defstruct [:primes]

  @type row :: Row.t
  @type t :: %__MODULE__{primes: [row]}

  @doc """
  Accepts an initial prime row and returns a matrix containing the ordered
  prime rows for generating the 2D matrix.

  ##Example

      iex> row = Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      iex> matrix = Webern.Matrix.new(row)
      iex> length(matrix.primes)
      12
      iex> List.first(matrix.primes) == row
      true
      iex> List.last(matrix.primes)
      %Webern.Row{
        pitch_classes: [11, 1, 0, 2, 3, 5, 4, 6, 7, 9, 8, 10]
      }

  """
  @spec new(row) :: __MODULE__.t
  def new(row = %Row{}) do
    %__MODULE__{primes: build_primes(row)}
  end

  defp build_primes(row = %Webern.Row{pitch_classes: pcs}) do
    with inverse <- Row.inverse(row, List.first(pcs)) do
      Enum.map(inverse.pitch_classes, fn start ->
        Row.prime(row, start)
      end)
    end
  end
end

defimpl String.Chars, for: Webern.Matrix do
  def to_string(%Webern.Matrix{primes: primes}) do
    primes
    |> Enum.map(&Kernel.to_string/1)
    |> Enum.join("\n")
  end
end

defimpl Webern.Lilypond, for: Webern.Matrix do
  @transforms [
    p: :prime,
    r: :retrograde,
    i: :inverse, ri:
    :retrograde_inverse,
    ir: :inverse_retrograde
  ]

  alias Webern.Lilypond.{Utils, Webern.Row}

  def to_lily(matrix = %Webern.Matrix{}) do
    Utils.lilypond_file_content(
      matrix_pitches_to_lily(matrix)
    )
  end

  def matrix_pitches_to_lily(matrix = %Webern.Matrix{}) do
    [:p, :r, :i, :ri, :ir]
    |> Enum.map(&transformation_form_to_lily(matrix, &1))
    |> Enum.join("\n      \\bar \"||\"\n")
  end

  def transformation_form_to_lily(matrix, transform) do
    matrix.primes
    |> Enum.map(fn p ->
      with row <- apply(Webern, @transforms[transform], [p]) do
        row
        |> Row.row_pitches_to_lily
        |> add_transformation_markup(transform, List.first(p.pitch_classes))
      end
    end)
    |> Enum.map(&"      #{&1}")
    |> Enum.join("\n")
  end

  def add_transformation_markup(str, form, index) do
    with  [h | t] <- String.split(str, " "),
          marked_h <- h <> ~s(\\mark "#{form}#{index}")
    do
      Enum.join([marked_h | t], " ")
    end
  end
end
