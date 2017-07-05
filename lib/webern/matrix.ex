defmodule Webern.Matrix do
  alias Webern.Row

  defstruct [:primes]

  def new(row = %Row{}) do
    %__MODULE__{primes: build_primes(row)}
  end

  defp build_primes(row) do
    Enum.map(Row.inverse(row).pitch_classes, fn start ->
      Row.p(row, start)
    end)
  end
end

defimpl String.Chars, for: Webern.Matrix do
  def to_string(%Webern.Matrix{primes: primes}) do
    Enum.map(primes, &Kernel.to_string/1)
    |> Enum.join("\n")
  end
end

defimpl Webern.Lilypond, for: Webern.Matrix do
  def to_lily(matrix = %Webern.Matrix{}) do
    [
      "\\version \"2.17.0\"",
      "\\language \"english\"",
      "",
      "\\new Score {",
      "  \\new Staff {",
      "    {",
      "      \\override Staff.TimeSignature #'stencil = ##f",
      "      \\override Staff.Stem #'transparent = ##t",
      "      \\accidentalStyle Score.dodecaphonic",
      "      \\time 12/4",
      matrix_pitches_to_lily(matrix),
      "      \\bar \"|.\"",
      "    }",
      "  }",
      "}"
    ] |> Enum.join("\n")
  end

  def matrix_pitches_to_lily(matrix = %Webern.Matrix{}) do
    [
      transformation_form_to_lily(matrix, &Webern.p/1, "p"),
      transformation_form_to_lily(matrix, &Webern.r/1, "r"),
      transformation_form_to_lily(matrix, &Webern.i/1, "i"),
      transformation_form_to_lily(matrix, &Webern.ri/1, "ri"),
      transformation_form_to_lily(matrix, &Webern.ir/1, "ir")
    ] |> Enum.join("\n      \\bar \"||\"\n")
  end

  def transformation_form_to_lily(matrix, func, markup_str) do
    Enum.map(matrix.primes, fn p ->
      func.(p)
      |> Webern.Lilypond.Webern.Row.row_pitches_to_lily
      |> String.split(" ")
      |> add_translation_markup(markup_str, List.first(p.pitch_classes))
      |> Enum.join(" ")
    end)
    |> Enum.map(&"      #{&1}")
    |> Enum.join("\n")
  end

  def add_translation_markup([h|t], form, index) do
    with marked_h <- h <> "\\mark \"#{form}#{index}\"" do
      [marked_h|t]
    end
  end
end
