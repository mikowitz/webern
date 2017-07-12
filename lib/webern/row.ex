defmodule Webern.Row do
  @moduledoc """
  Models a tone row built from pitches from the 12 semitone chromatic scale.

  N.B. Although the main functionality for row creation/transformation
  is defined in this module, the `Webern` module provides a more user-friendly
  interface, and it is recommended to use the functions defined there for
  your own work.

  `Webern.Row` implements the `String.Chars` protocol, so that
  `Kernel.to_string/1` returns a tab-separated string represenation of the row
  converted to pitch class names, where 0 == `c`

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> to_string
      "c   d   cs  ef  e   fs  f   g   af  bf  a   b"

  `Webern.Row` also implements the `Webern.Lilypond` protocol, whose
  `to_lily/1` function embeds the result of `to_string/1` inside
  a Lilypond document that can be saved to a file and compiled.

  """

  defstruct [:pitch_classes]

  @type t :: %__MODULE__{pitch_classes: [integer]}
  @pitch_classes ~w( c cs d ef e f fs g af a bf b )

  @doc """
  Accepts a list of pitch classes and returns a `Webern.Row` struct
  built from those pitch classes.

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      %Webern.Row{
        pitch_classes: [0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11]
      }

  """
  @spec new([integer]) :: __MODULE__.t
  def new(pitch_classes) do
    %__MODULE__{pitch_classes: pitch_classes}
  end

  @doc """
  Returns the prime form of `row` transposed to begin at pitch class `start`

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.prime(3)
      %Webern.Row{
        pitch_classes: [3, 5, 4, 6, 7, 9, 8, 10, 11, 1, 0, 2]
      }

  """
  @spec prime(__MODULE__.t, integer) :: __MODULE__.t
  def prime(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start)
  end

  @doc """
  Transposes `row` to begin at pitch class `start` and returns the retrograde
  form

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.retrograde(4)
      %Webern.Row{
        pitch_classes: [3, 1, 2, 0, 11, 9, 10, 8, 7, 5, 6, 4]
      }

  """
  @spec retrograde(__MODULE__.t, integer) :: __MODULE__.t
  def retrograde(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> _retrograde
  end

  @doc """
  Transposes `row` to begin at pitch class `start` and returns the inverse form

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.inverse(1)
      %Webern.Row{
        pitch_classes: [1, 11, 0, 10, 9, 7, 8, 6, 5, 3, 4, 2]
      }

  """
  @spec inverse(__MODULE__.t, integer) :: __MODULE__.t
  def inverse(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> _inverse
  end

  @doc """
  Transposes `row` to begin at pitch class `start` and returns the
  retrograded inverse form

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.retrograde_inverse(5)
      %Webern.Row{
        pitch_classes: [6, 8, 7, 9, 10, 0, 11, 1, 2, 4, 3, 5]
      }

  """
  @spec retrograde_inverse(__MODULE__.t, integer) :: __MODULE__.t
  def retrograde_inverse(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> _inverse |> _retrograde
  end

  @doc """
  Transposes `row` to begin at pitch class `start` and returns the
  inverted retrograde form

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.inverse_retrograde(8)
      %Webern.Row{
        pitch_classes: [7, 9, 8, 10, 11, 1, 0, 2, 3, 5, 4, 6]
      }

  """
  @spec inverse_retrograde(__MODULE__.t, integer) :: __MODULE__.t
  def inverse_retrograde(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> _retrograde |> _inverse
  end

  @doc """
  Converts `row` to a list of pitch class indices or strings.

  When passed only a `Webern.Row`, `to_list/2` will return `row.pitch_classes`.

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.to_list
      [0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11]

  When passed an optional keyword list including `[to_pitches: true]`,
  `to_list/2` will convert the pitch classes to their lilypond pitch names,
  using 0 == `c`.

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.to_list(to_pitches: true)
      ["c", "d", "cs", "ef", "e", "fs", "f", "g", "af", "bf", "a", "b"]

  A different value for `:zero_pitch` can be passed in the
  keyword list.

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.to_list(to_pitches: true, zero_pitch: "ef")
      ["ef", "f", "e", "fs", "g", "a", "af", "bf", "b", "cs", "c", "d"]

  """
  @spec to_list(__MODULE__.t, Keyword.t | nil) :: [integer] | [String.t]
  def to_list(row = %__MODULE__{}, opts \\ []) do
    with  to_pitches <- Keyword.get(opts, :to_pitches, false),
          zero_pitch <- Keyword.get(opts, :zero_pitch, "c"),
    do: to_list(row, to_pitches, zero_pitch)
  end

  defp to_list(%__MODULE__{pitch_classes: pcs}, false, _), do: pcs
  defp to_list(row = %__MODULE__{}, true, zero_pitch) do
    with zero_pci <- Enum.find_index(@pitch_classes, &(&1 == zero_pitch)) do
      row |> transpose(zero_pci) |> to_pitch_classes
    end
  end

  defp to_pitch_classes(%__MODULE__{pitch_classes: pcs}) do
    Enum.map(pcs, &Enum.at(@pitch_classes, &1))
  end

  defp zero(%__MODULE__{pitch_classes: [h | _] = pitch_classes}) do
    new(Enum.map(pitch_classes, &(normalize(&1 - h))))
  end

  defp _retrograde(%__MODULE__{pitch_classes: pitch_classes}) do
    new(Enum.reverse(pitch_classes))
  end

  defp _inverse(%__MODULE__{pitch_classes: [h | _] = pitch_classes}) do
    new(Enum.map(pitch_classes, &(normalize(2 * h - &1))))
  end

  defp transpose(%__MODULE__{pitch_classes: pitch_classes}, interval) do
    new(Enum.map(pitch_classes, &(normalize(&1 + interval))))
  end

  defp normalize(n) when n < 0, do: normalize(n + (-n * 12))
  defp normalize(n), do: rem(n, 12)
end

defimpl String.Chars, for: Webern.Row do
  def to_string(row = %Webern.Row{}) do
    row
    |> Webern.Row.to_list(to_pitches: true)
    |> Enum.map(&String.ljust(&1, 4))
    |> Enum.join("")
    |> String.strip
  end
end

defimpl Webern.Lilypond, for: Webern.Row do
  alias Webern.Lilypond.Utils

  @doc """
  Generates the contents for a lilypond document to display `row` on a staff
  """
  def to_lily(row = %Webern.Row{}) do
    Utils.lilypond_file_content(
      "      " <> row_pitches_to_lily(row)
    )
  end

  @doc """
  Formats the pitch classes for the given `row` to display in the middle C
  octave in LilyPond markup.
  """
  def row_pitches_to_lily(row = %Webern.Row{}) do
    row
    |> Webern.Row.to_list(to_pitches: true)
    |> Enum.map(&"#{&1}'")
    |> Enum.join(" ")
  end
end
