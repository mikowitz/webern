defmodule Webern.Lilypond.Utils do
  def lilypond_file_content(tone_row_lily) do
    [
      "\\version \"2.17.0\"",
      "\\language \"english\"",
      "",
      "\\new Score {",
      "  \\new Staff {",
      "    {",
      "      \\override Staff.TimeSignature #'stencil = ##f",
      "      \\override Staff.Stem #'transparent = ##t",
      "      \\accidentalStyle Score.dodecaphonic",
      "      \\time 12/4",
      tone_row_lily,
      "      \\bar \"|.\"",
      "    }",
      "  }",
      "}"
    ] |> Enum.join("\n")
  end
end
