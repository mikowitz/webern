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
  def to_string(matrix = %Webern.Matrix{primes: primes}) do
    Enum.map(primes, &Kernel.to_string/1)
    |> Enum.join("\n")
  end
end
