defprotocol Webern.Lilypond do
  @moduledoc """
  `Webern.Lilypond` is a protocol providing a single method, `to_lily/1`,
  defining a lilypond format for the provided `Webern.Row` or `Webern.Matrix`.

  `to_lily/1` returns a complete lilypond document that can be saved to a file
  and compiled to PDF.
  """

  @type lilypondable :: Webern.Row.t | Webern.Matrix.t

  @doc """
  Accepts a single argument `lilypondable` which is a `Webern.Row` or
  `Webern.Matrix` and returns a complete LilyPond document string representing
  the provided LilyPond-able struct.
  """
  @spec to_lily(lilypondable) :: String.t
  def to_lily(lilypondable)
end
