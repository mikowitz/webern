defmodule Webern.RowTest do
  use ExUnit.Case
  alias Webern.Row

  @op_28 [10, 9, 0, 11, 3, 4, 1, 2, 6, 5, 8, 7]

  test ".new/1 returns a row from the given pitch class list" do
    assert Row.new(@op_28) == %Webern.Row{
      pitch_classes: [10, 9, 0, 11, 3, 4, 1, 2, 6, 5, 8, 7]
    }
  end

  test ".zero/1 returns a row with the initial pitch class set to 0" do
    assert Row.new(@op_28) |> Row.zero == %Webern.Row{
      pitch_classes: [0, 11, 2, 1, 5, 6, 3, 4, 8, 7, 10, 9]
    }
  end

  test ".retrograde/1 returns the retrograde of the given row" do
    assert Row.new(@op_28) |> Row.retrograde == %Webern.Row{
      pitch_classes: [7, 8, 5, 6, 2, 1, 4, 3, 11, 0, 9, 10]
    }
  end

  test ".inverse/1 returns the inversion of the given row" do
    assert Row.new(@op_28) |> Row.inverse == %Webern.Row{
      pitch_classes: [10, 11, 8, 9, 5, 4, 7, 6, 2, 3, 0, 1]
    }
  end

  test ".retrograde_inverse/1 returns the retrograde of the row's inversion" do
    assert Row.new(@op_28) |> Row.retrograde_inverse == %Webern.Row{
      pitch_classes: [1, 0, 3, 2, 6, 7, 4, 5, 9, 8, 11, 10]
    }
  end

  test ".inverse_retrograde/1 returns the inverse of the row's retrograde" do
    assert Row.new(@op_28) |> Row.inverse_retrograde == %Webern.Row{
      pitch_classes: [7, 6, 9, 8, 0, 1, 10, 11, 3, 2, 5, 4]
    }
  end

  test ".transpose/2 transposes the row by the given interval" do
    assert Row.new(@op_28) |> Row.transpose(-4) == %Webern.Row{
      pitch_classes: [6, 5, 8, 7, 11, 0, 9, 10, 2, 1, 4, 3]
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
