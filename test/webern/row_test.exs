defmodule Webern.RowTest do
  use ExUnit.Case
  alias Webern.Row
  doctest Webern.Row

  @op_28 [10, 9, 0, 11, 3, 4, 1, 2, 6, 5, 8, 7]

  test ".new/1 returns a row from the given pitch class list" do
    assert Row.new(@op_28) == %Webern.Row{
      pitch_classes: [10, 9, 0, 11, 3, 4, 1, 2, 6, 5, 8, 7]
    }
  end

  test ".prime/2 returns the prime version of a row starting at a given step" do
    assert Row.new(@op_28) |> Row.prime(2) == %Webern.Row{
      pitch_classes: [2, 1, 4, 3, 7, 8, 5, 6, 10, 9, 0, 11]
    }
  end

  test ".retrograde/2 returns the retrograde of a row that starts at the given step" do
    assert Row.new(@op_28) |> Row.retrograde(5) == %Webern.Row{
      pitch_classes: [2, 3, 0, 1, 9, 8, 11, 10, 6, 7, 4, 5]
    }
  end

  test ".inverse/2 returns an inverse version of a row starting at a given step" do
    assert Row.new(@op_28) |> Row.inverse(6) == %Webern.Row{
      pitch_classes: [6, 7, 4, 5, 1, 0, 3, 2, 10, 11, 8, 9]
    }
  end

  test ".retrograde_inverse/2 returns the retrograde of an inverted row that starts at a given step" do
    assert Row.new(@op_28) |> Row.retrograde_inverse(9) == %Webern.Row{
      pitch_classes: [0, 11, 2, 1, 5, 6, 3, 4, 8, 7, 10, 9]
    }
  end

  test ".inverse_retrograde/2 returns the inverse of the retrograde of a row starting at a given step" do
    assert Row.new(@op_28) |> Row.inverse_retrograde(5) == %Webern.Row{
      pitch_classes: [2, 1, 4, 3, 7, 8, 5, 6, 10, 9, 0, 11]
    }
  end

  describe ".to_list" do
    test ".to_list/1 returns the pitch class list for the row" do
      assert Row.to_list(Row.new(@op_28)) == @op_28
    end

    test ".to_list/2 returns the pitch class list mapped to pitches with 0 set to 'c', or the passed-in pitch class" do
      assert Row.to_list(Row.new(@op_28), to_pitches: true) == ~w( bf a c b ef e cs d fs f af g )

      assert Row.to_list(Row.new(@op_28), to_pitches: true, zero_pitch: "d") == ~w( c b d cs f fs ef e af g bf a )
    end
  end
end
