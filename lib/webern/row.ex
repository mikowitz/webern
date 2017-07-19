defmodule Webern.Row do
  @moduledoc """
  Models a serializeable row.

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

  defstruct [:pitch_classes, :modulo]

  @type t :: %__MODULE__{pitch_classes: [integer], modulo: integer | nil}
  @pitch_classes ~w( c cs d ef e f fs g af a bf b )
  @all_pitch_classes %{
    0.0 => "c", 0.5 => "cqs", 1.0 => "cs", 1.5 => "ctqs", 2.0 => "d",
    2.5 => "etqf", 3.0 => "ef", 3.5 => "eqf", 4.0 => "e", 4.5 => "esq",
    5.0 => "f", 5.5 => "fqs", 6.0 => "fs", 6.5 => "ftqs", 7.0 => "g",
    7.5 => "atqf", 8.0 => "af", 8.5 => "aqf", 9.0 => "a", 9.5 => "btqf",
    10.0 => "bf", 10.5 => "bqf", 11.0 => "b", 11.5 => "bqs"
  }

  @doc """
  Accepts `pitch_classes`, a list of integers between 0 and 11, and returns
  a `Webern.Row` struct.

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      %Webern.Row{
        pitch_classes: [0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11],
        modulo: 12
      }

  `new/2` can also take an optional second argument specifying the modulo
  for the row.  If not given, this defaults to the highest value in the row + 1.
  This assumes an integral-based row of pitch classes. A row using non-integral
  values should always specify a modulo to avoid unexpected transformations.

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 5])
      %Webern.Row{
        pitch_classes: [0, 2, 1, 3, 4, 5],
        modulo: 6
      }

      iex> Webern.Row.new([0, 2, 1, 3, 4, 5], 7)
      %Webern.Row{
        pitch_classes: [0, 2, 1, 3, 4, 5],
        modulo: 7
      }

  """
  @spec new([integer], integer | nil) :: __MODULE__.t
  def new(pitch_classes, modulo \\ nil) do
    with modulo <- modulo || Enum.max(pitch_classes) + 1 do
      %__MODULE__{pitch_classes: pitch_classes, modulo: modulo}
    end
  end

  @doc """
  Returns the prime form of `row` transposed to begin at pitch class `start`

  ## Example

      iex> Webern.Row.new([0, 2, 1, 3, 4, 6, 5, 7, 8, 10, 9, 11])
      ...> |> Row.prime(3)
      %Webern.Row{
        pitch_classes: [3, 5, 4, 6, 7, 9, 8, 10, 11, 1, 0, 2],
        modulo: 12
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
        pitch_classes: [3, 1, 2, 0, 11, 9, 10, 8, 7, 5, 6, 4],
        modulo: 12
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
        pitch_classes: [1, 11, 0, 10, 9, 7, 8, 6, 5, 3, 4, 2],
        modulo: 12
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
        pitch_classes: [6, 8, 7, 9, 10, 0, 11, 1, 2, 4, 3, 5],
        modulo: 12
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
        pitch_classes: [7, 9, 8, 10, 11, 1, 0, 2, 3, 5, 4, 6],
        modulo: 12
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
    Enum.map(pcs, fn pc ->
      case is_integer(pc) do
        true -> Enum.at(@pitch_classes, pc, pc)
        false -> to_pitch_with_frequency_annotation(pc)
      end
    end)
  end

  defp to_pitch_with_frequency_annotation(p) do
    c0 = 440.0 * :math.pow(2, -4.75)
    n = Float.round(12 * :math.log2(p / c0) / 0.5, 0) * 0.5
    octave = round(Float.floor(n / 12))
    pc = Map.get(@all_pitch_classes, n - (12 * octave))
    "#{pc}#{octave_string(octave)} ^\\markup { \\box #{p} }"
  end

  defp octave_string(3), do: ""
  defp octave_string(o) when o < 3, do: String.duplicate(",", 3 - o)
  defp octave_string(o) when o > 3, do: String.duplicate("'", o - 3)

  defp zero(%__MODULE__{pitch_classes: [h | _] = pitch_classes, modulo: m}) do
    new(Enum.map(pitch_classes, &(normalize(&1 - h, m))), m)
  end

  defp _retrograde(%__MODULE__{pitch_classes: pitch_classes, modulo: m}) do
    new(Enum.reverse(pitch_classes), m)
  end

  defp _inverse(%__MODULE__{pitch_classes: [h | _] = pcs, modulo: m}) do
    new(Enum.map(pcs, &normalize(2 * h - &1, m)), m)
  end

  defp transpose(%__MODULE__{pitch_classes: pcs, modulo: m}, interval) do
    new(Enum.map(pcs, &(normalize(&1 + interval, m))), m)
  end

  defp normalize(n, :infinity), do: Float.round(n, 1)
  defp normalize(n, m) when n < 0, do: normalize(n + (-n * m), m)
  defp normalize(n, m), do: rem(n, m)
end

defimpl String.Chars, for: Webern.Row do
  def to_string(row = %Webern.Row{}) do
    row
    |> Webern.Row.to_list(to_pitches: true)
    |> Enum.map(&" #{String.ljust(&1, 3)}")
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
    |> Enum.map(&"#{&1}#{octave_mark(&1)}")
    |> Enum.join(" ")
  end

  defp octave_mark(str) do
    case Regex.match?(~r/markup/, str) do
      true -> ""
      false -> "'"
    end
  end
end
