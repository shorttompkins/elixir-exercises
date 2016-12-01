defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list

  def accumulate(list, fun) do
    _accumulate([], list, fun)
  end
  defp _accumulate(acc, [], _), do: acc
  defp _accumulate(acc, [head | tail], fun) do
    _accumulate(acc ++ [fun.(head)], tail, fun)
  end

end
