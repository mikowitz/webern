defmodule WebernTest do
  use ExUnit.Case
  import Webern

  @op_24 [11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9]

  test ".row/1 returns a row from a given pitch class list" do
    assert row(@op_24) == %Webern.Row{
      pitch_classes: [11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9]
    }
  end

  describe ".p" do
    test ".p/1 returns the original prime form of the row" do
      assert p(row(@op_24)) == %Webern.Row{
        pitch_classes: [11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9]
      }
    end

    test ".p/1 returns the form of the row starting at the given step" do
      assert p(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [3, 2, 6, 7, 11, 10, 0, 8, 9, 4, 5, 1]
      }
    end
  end

  describe ".r" do
    test ".r/1 returns the original prime form of the row" do
      assert r(row(@op_24)) == %Webern.Row{
        pitch_classes: [9, 1, 0, 5, 4, 8, 6, 7, 3, 2, 10, 11]
      }
    end

    test ".r/1 returns the form of the row starting at the given step" do
      assert r(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [1, 5, 4, 9, 8, 0, 10, 11, 7, 6, 2, 3]
      }
    end
  end

  describe ".i" do
    test ".i/1 returns the original prime form of the row" do
      assert i(row(@op_24)) == %Webern.Row{
        pitch_classes: [11, 0, 8, 7, 3, 4, 2, 6, 5, 10, 9, 1]
      }
    end

    test ".i/1 returns the form of the row starting at the given step" do
      assert i(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [3, 4, 0, 11, 7, 8, 6, 10, 9, 2, 1, 5]
      }
    end
  end

  describe ".ri" do
    test ".ri/1 returns the original prime form of the row" do
      assert ri(row(@op_24)) == %Webern.Row{
        pitch_classes: [1, 9, 10, 5, 6, 2, 4, 3, 7, 8, 0, 11]
      }
    end

    test ".ri/1 returns the form of the row starting at the given step" do
      assert ri(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [5, 1, 2, 9, 10, 6, 8, 7, 11, 0, 4, 3]
      }
    end
  end

  describe ".ir" do
    test ".ir/1 returns the inverse of the retrograde of the row" do
      assert ir(row(@op_24)) == %Webern.Row{
        pitch_classes: [9, 5, 6, 1, 2, 10, 0, 11, 3, 4, 8, 7]
      }
    end

    test ".ir/, returns the inverse of the retrograde of a row starting at a given step" do
      assert ir(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [1, 9, 10, 5, 6, 2, 4, 3, 7, 8, 0, 11]
      }
    end
  end
end
