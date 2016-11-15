defmodule Chap6 do
  def sum(n), do: _sum(n, 0)

  defp _sum(0, acc), do: acc
  defp _sum(n, acc), do: _sum(n-1, acc + n)
end
