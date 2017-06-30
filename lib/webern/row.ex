defmodule Webern.Row do
  defstruct [:pitch_classes]

  def new(pitch_classes) do
    %__MODULE__{pitch_classes: pitch_classes}
  end

  def zero(%__MODULE__{pitch_classes: pitch_classes}) do
    with [h|_] <- pitch_classes do
      new(Enum.map(pitch_classes, &(normalize(&1 - h))))
    end
  end

  def retrograde(%__MODULE__{pitch_classes: pitch_classes}) do
    new(Enum.reverse(pitch_classes))
  end

  def inverse(%__MODULE__{pitch_classes: pitch_classes}) do
    with [h|_] <- pitch_classes do
      new(Enum.map(pitch_classes, &(normalize(h - (&1 - h)))))
    end
  end

  def retrograde_inverse(row = %__MODULE__{}) do
    row |> inverse |> retrograde
  end

  def inverse_retrograde(row = %__MODULE__{}) do
    row |> retrograde |> inverse
  end

  def transpose(%__MODULE__{pitch_classes: pitch_classes}, interval) do
    new(Enum.map(pitch_classes, &(normalize(&1 + interval))))
  end

  def p(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start)
  end

  def r(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> retrograde
  end

  def i(row = %__MODULE__{}, start) do
    row |> zero |> inverse |> transpose(start)
  end

  def ri(row = %__MODULE__{}, start) do
    row |> zero |> inverse |> transpose(start) |> retrograde
  end

  def ir(row = %__MODULE__{}, start) do
    row |> zero |> transpose(start) |> retrograde |> inverse
  end

  defp normalize(n) when n < 0, do: normalize(n + (-n * 12))
  defp normalize(n), do: rem(n, 12)
end
