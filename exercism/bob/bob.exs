defmodule Bob do
  def hey(input) do
    cond do
      is_question?(input) -> "Sure."
      is_blank?(input) -> "Fine. Be that way!"
      is_shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp is_question?(input), do: String.ends_with?(input, "?")

  defp is_blank?(input) do
    input
      |> String.trim
      |> String.length == 0
  end

  defp is_shouting?(input) do
    input == String.upcase(input) && input != String.downcase(input)
  end
end