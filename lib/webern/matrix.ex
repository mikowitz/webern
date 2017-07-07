defmodule Webern.Matrix do
  @moduledoc false

  alias Webern.Row

  defstruct [:primes]

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
      with row <- apply(Webern, transform, [p]) do
        row
        |> Row.row_pitches_to_lily
        |> add_transformation_markup(transform, List.first(p.pitch_classes))
      end
    end)
    |> Enum.map(&"      #{&1}")
    |> Enum.join("\n")
  end

  def add_transformation_markup(str, form, index) do
    with  [h|t] <- String.split(str, " "),
          marked_h <- h <> "\\mark \"#{form}#{index}\""
    do
      Enum.join([marked_h|t], " ")
    end
  end
end
