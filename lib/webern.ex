defmodule Webern do
  @pitch_classes ~w( c cs d ef e f fs g af a bf b )

  alias Webern.{Row, Matrix}

  def row(source_row) do
    Row.new(source_row)
  end

  def p(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.p(row, start)
    end
  end

  def r(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.r(row, start)
    end
  end

  def i(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.i(row, start)
    end
  end

  def ri(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.ri(row, start)
    end
  end

  def ir(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.ir(row, start)
    end
  end

  def to_pitches(object, starting_pitch \\ nil)
  def to_pitches(row = %Webern.Row{pitch_classes: pcs}, starting_pitch) do
    case starting_pitch do
      nil -> Enum.map(pcs, &Enum.at(@pitch_classes, &1))
      pitch ->
        with index <- Enum.find_index(@pitch_classes, &(&1 == pitch)) do
          to_pitches(p(row, index))
        end
    end
  end
  def to_pitches(%Webern.Matrix{primes: primes}, starting_pitch) do
    Enum.map(primes, &to_pitches(&1, starting_pitch))
  end

  def matrix(row = %Webern.Row{}) do
    Matrix.new(row)
  end
end
