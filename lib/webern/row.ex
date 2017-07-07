defmodule Webern.Row do
  @moduledoc false
  defstruct [:pitch_classes]

  def new(pitch_classes) do
    %__MODULE__{pitch_classes: pitch_classes}
  end

  def prime(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start)
  end

  def retrograde(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> _retrograde
  end

  def inverse(row = %__MODULE__{}, start) do
    row |> zero |> _inverse |> transpose(start)
  end

  def retrograde_inverse(row = %__MODULE__{}, start) do
    row |> zero |> _inverse |> transpose(start) |> _retrograde
  end

  def inverse_retrograde(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> _retrograde |> _inverse
  end

  defp normalize(n) when n < 0, do: normalize(n + (-n * 12))
  defp normalize(n), do: rem(n, 12)

  defp zero(%__MODULE__{pitch_classes: pitch_classes}) do
    with [h | _] <- pitch_classes do
      new(Enum.map(pitch_classes, &(normalize(&1 - h))))
    end
  end

  defp _retrograde(%__MODULE__{pitch_classes: pitch_classes}) do
    new(Enum.reverse(pitch_classes))
  end

  defp _inverse(%__MODULE__{pitch_classes: pitch_classes}) do
    with [h | _] <- pitch_classes do
      new(Enum.map(pitch_classes, &(normalize(h - (&1 - h)))))
    end
  end

  defp transpose(%__MODULE__{pitch_classes: pitch_classes}, interval) do
    new(Enum.map(pitch_classes, &(normalize(&1 + interval))))
  end

end

defimpl String.Chars, for: Webern.Row do
  def to_string(row = %Webern.Row{}) do
    row
    |> Webern.to_pitches
    |> Enum.map(&String.ljust(&1, 4))
    |> Enum.join("")
    |> String.strip
  end
end

defimpl Webern.Lilypond, for: Webern.Row do
  alias Webern.Lilypond.Utils

  def to_lily(row = %Webern.Row{}) do
    Utils.lilypond_file_content(
      "      " <> row_pitches_to_lily(row)
    )
  end

  def row_pitches_to_lily(row = %Webern.Row{}) do
    row
    |> Webern.to_pitches
    |> Enum.map(&"#{&1}'")
    |> Enum.join(" ")
  end
end
