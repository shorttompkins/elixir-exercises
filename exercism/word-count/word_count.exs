defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    words = individualize(sentence)
    words
      |> Enum.uniq
      |> Enum.reduce(%{}, &Map.put(&2, &1, _count(words, &1)))
  end
  defp _count(words, word) do
    Enum.filter(words, &(&1 == word)) |>
      Enum.count
  end

  defp individualize(sentence) do
    sentence
      |> String.downcase
      |> String.replace("_", " ")
      |> String.replace(~r/[\\'!"#$%&()*+,\.\/:;<=>?@\[\]^_`{|}~]/, "")
      |> String.split
  end
end
