defmodule MyList do
  def mapsum(list, func) do
    do_mapsum(list, func, 0)
  end

  defp do_mapsum([head | []], func, acc), do: acc + func.(head)

  defp do_mapsum([head | tail], func, acc) do
    do_mapsum(tail, func, acc + func.(head))
  end

end
