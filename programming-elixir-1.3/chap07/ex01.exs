defmodule MyList do
  def mapsum(list, func) do
    _mapsum(list, func, 0)
  end

  defp _mapsum([head | []], func, acc), do: acc + func.(head)

  defp _mapsum([head | tail], func, acc) do
    _mapsum(tail, func, acc + func.(head))
  end

end
