defmodule MyList do
  # def max(list = [head | _tail]), do: _max(list, head)
  def max([head | tail]), do: _max([head | tail], head)

  defp _max([], current), do: current
  defp _max([head | tail], current) when head > current, do: _max(tail, head)
  defp _max([_head | tail], current), do:  _max(tail, current)
end
