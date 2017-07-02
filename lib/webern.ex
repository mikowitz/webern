defmodule Webern do
  alias Webern.Row

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
end
