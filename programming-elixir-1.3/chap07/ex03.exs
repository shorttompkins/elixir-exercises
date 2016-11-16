defmodule MyList do
  def caesar([], _), do: []
  def caesar([head | tail], shift) do
    [ shift_letter(head, shift) | caesar(tail, shift)]
  end

  defp shift_letter(letter, shift) when letter + shift > 122, do: (letter + shift) - 26
  defp shift_letter(letter, shift), do: letter + shift
end
