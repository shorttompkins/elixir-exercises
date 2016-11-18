defmodule MyList do
  # def max([head | tail]), do: do_max([head | tail], head)   # ok...
  def max(list = [head | _tail]), do: do_max(list, head)      # better!

  defp do_max([], current), do: current
  defp do_max([head | tail], current) when head > current, do: do_max(tail, head)
  defp do_max([_head | tail], current), do:  do_max(tail, current)
end
