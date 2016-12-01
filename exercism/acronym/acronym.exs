defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    words = individualize(string)
    _abbreviate(words, "")
  end
  defp _abbreviate([], acc), do: acc
  defp _abbreviate([head | tail], acc) do
    _abbreviate(tail, acc <> String.first(head))
  end

  def individualize(phrase) do
    phrase
      |> String.replace("-", " ")
      |> split_camelcase
      |> String.upcase
      |> String.replace(~r/[\\'!"#$%&()*+,\.\/:;<=>?@\[\]^_`{|}~]/, "")
      |> String.split
  end

  def split_camelcase(word) do
    _split_camelcase(word, "")
  end
  defp _split_camelcase("", acc), do: String.trim_leading(acc)
  defp _split_camelcase(word, acc) do
    {first, tail} = String.split_at(word, 1)
    if (String.downcase(first) != first) do
      _split_camelcase(tail, acc <> " " <> first)
    else
      _split_camelcase(tail, acc <> first)
    end
  end

end
