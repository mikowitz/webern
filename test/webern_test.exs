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

    test ".p/2 returns the prime form of the row starting at the given step" do
      assert p(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [3, 2, 6, 7, 11, 10, 0, 8, 9, 4, 5, 1]
      }
    end
  end

  describe ".r" do
    test ".r/1 returns the retrograde form of the row" do
      assert r(row(@op_24)) == %Webern.Row{
        pitch_classes: [9, 1, 0, 5, 4, 8, 6, 7, 3, 2, 10, 11]
      }
    end

    test ".r/2 returns the retrograde form for the row starting at the given step" do
      assert r(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [1, 5, 4, 9, 8, 0, 10, 11, 7, 6, 2, 3]
      }
    end
  end

  describe ".i" do
    test ".i/1 returns the inverse form of the row" do
      assert i(row(@op_24)) == %Webern.Row{
        pitch_classes: [11, 0, 8, 7, 3, 4, 2, 6, 5, 10, 9, 1]
      }
    end

    test ".i/2 returns the inverse form of the row starting at the given step" do
      assert i(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [3, 4, 0, 11, 7, 8, 6, 10, 9, 2, 1, 5]
      }
    end
  end

  describe ".ri" do
    test ".ri/1 returns the retrograde inverse form of the row" do
      assert ri(row(@op_24)) == %Webern.Row{
        pitch_classes: [1, 9, 10, 5, 6, 2, 4, 3, 7, 8, 0, 11]
      }
    end

    test ".ri/2 returns the retrograde inverse form for the row starting at the given step" do
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

    test ".ir/2 returns the inverse of the retrograde of a row starting at a given step" do
      assert ir(row(@op_24), 3) == %Webern.Row{
        pitch_classes: [1, 9, 10, 5, 6, 2, 4, 3, 7, 8, 0, 11]
      }
    end
  end

  describe ".to_pitches" do
    test ".to_pitches/1 returns the row as realized with pitches, letting 0 = C" do
      assert to_pitches(row(@op_24)) == ~w( b bf d ef g fs af e f c cs a )
    end

    test ".to_pitches/2 returns the row as realized with pitches, passing along the pitch for the first step" do
      assert to_pitches(row(@op_24), "d") == ~w( d cs f fs bf a b g af ef e c )
    end
  end

  describe ".matrix/1" do
    test "it returns a 12x12 matrix for the given row" do
      row = row(@op_24)
      matrix = matrix(row)

      assert List.first(matrix.primes).pitch_classes == @op_24
      assert List.last(matrix.primes).pitch_classes ==
        [1, 0, 4, 5, 9, 8, 10, 6, 7, 2, 3, 11]
    end
  end

  describe ".to_string/1" do
    test "it returns a space separated row when called with a row" do
      assert to_string(row(@op_24)) == "b   bf  d   ef  g   fs  af  e   f   c   cs  a"
    end

    test "it returns a space separated matrix when called with a matrix" do
      assert to_string(matrix(row(@op_24))) == """
b   bf  d   ef  g   fs  af  e   f   c   cs  a
c   b   ef  e   af  g   a   f   fs  cs  d   bf
af  g   b   c   e   ef  f   cs  d   a   bf  fs
g   fs  bf  b   ef  d   e   c   cs  af  a   f
ef  d   fs  g   b   bf  c   af  a   e   f   cs
e   ef  g   af  c   b   cs  a   bf  f   fs  d
d   cs  f   fs  bf  a   b   g   af  ef  e   c
fs  f   a   bf  d   cs  ef  b   c   g   af  e
f   e   af  a   cs  c   d   bf  b   fs  g   ef
bf  a   cs  d   fs  f   g   ef  e   b   c   af
a   af  c   cs  f   e   fs  d   ef  bf  b   g
cs  c   e   f   a   af  bf  fs  g   d   ef  b
""" |> String.strip
    end
  end

  describe ".to_lily/2" do
    test "it writes the 48 labeled permutations of the row to a lilypond file and compiles it" do
      to_lily(matrix(row(@op_24)), "op_24")

      assert :ok == File.rm("op_24.ly")
      assert :ok == File.rm("op_24.pdf")
    end
  end
end
