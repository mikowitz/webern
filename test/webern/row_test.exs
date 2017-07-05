defmodule Webern.RowTest do
  use ExUnit.Case
  alias Webern.Row

  @op_28 [10, 9, 0, 11, 3, 4, 1, 2, 6, 5, 8, 7]

  test ".new/1 returns a row from the given pitch class list" do
    assert Row.new(@op_28) == %Webern.Row{
      pitch_classes: [10, 9, 0, 11, 3, 4, 1, 2, 6, 5, 8, 7]
    }
  end

  test ".p/2 returns the prime version of a row starting at a given step" do
    assert Row.new(@op_28) |> Row.p(2) == %Webern.Row{
      pitch_classes: [2, 1, 4, 3, 7, 8, 5, 6, 10, 9, 0, 11]
    }
  end

  test ".r/2 returns the retrograde of a row that starts at the given step" do
    assert Row.new(@op_28) |> Row.r(5) == %Webern.Row{
      pitch_classes: [2, 3, 0, 1, 9, 8, 11, 10, 6, 7, 4, 5]
    }
  end

  test ".i/2 returns an inverse version of a row starting at a given step" do
    assert Row.new(@op_28) |> Row.i(6) == %Webern.Row{
      pitch_classes: [6, 7, 4, 5, 1, 0, 3, 2, 10, 11, 8, 9]
    }
  end

  test ".ri/2 returns the retrograde of an inverted row that starts at a given step" do
    assert Row.new(@op_28) |> Row.ri(9) == %Webern.Row{
      pitch_classes: [0, 11, 2, 1, 5, 6, 3, 4, 8, 7, 10, 9]
    }
  end

  test ".ir/2 returns the inverse of the retrograde of a row starting at a given step" do
    assert Row.new(@op_28) |> Row.ir(5) == %Webern.Row{
      pitch_classes: [2, 1, 4, 3, 7, 8, 5, 6, 10, 9, 0, 11]
    }
  end
end
