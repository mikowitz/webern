defmodule Webern do
  @pitch_classes ~w( c cs d ef e f fs g af a bf b )

  alias Webern.{Row, Matrix}

  def row(source_row) do
    Row.new(source_row)
  end

  def prime(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.prime(row, start)
    end
  end
  defdelegate p(row, start \\ nil), to: __MODULE__, as: :prime

  def retrograde(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.retrograde(row, start)
    end
  end
  defdelegate r(row, start \\ nil), to: __MODULE__, as: :retrograde

  def inverse(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.inverse(row, start)
    end
  end
  defdelegate i(row, start \\ nil), to: __MODULE__, as: :inverse

  def retrograde_inverse(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.retrograde_inverse(row, start)
    end
  end
  defdelegate ri(row, start \\ nil), to: __MODULE__, as: :retrograde_inverse

  def inverse_retrograde(row = %Webern.Row{}, start \\ nil) do
    with start <- start || List.first(row.pitch_classes) do
      Row.inverse_retrograde(row, start)
    end
  end
  defdelegate ir(row, start \\ nil), to: __MODULE__, as: :inverse_retrograde

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

  def to_lily(object, filename) do
    File.write(filename <> ".ly", Webern.Lilypond.to_lily(object))
    "lilypond -o #{filename} #{filename}.ly"
    |> to_charlist |> :os.cmd
  end
end
