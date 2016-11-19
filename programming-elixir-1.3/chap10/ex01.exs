defmodule Chap10 do

  ## all?
  def all?(list, check \\ &(!!&1)) do
    do_all?(list, check, true)
  end

  defp do_all?(_, _, false), do: false
  defp do_all?([], _, pass), do: pass
  defp do_all?([head | tail], check, _pass), do: do_all?(tail, check, check.(head))

  ## each
  def each(list, apply) do
    do_each(list, apply)
  end

  defp do_each([], _), do: []
  defp do_each([head|tail], apply), do: [apply.(head) | do_each(tail, apply)]


  ## filter
  def filter(list, check) do
    do_filter(list, check, [])
  end

  defp do_filter([], _, new_list), do: new_list

  defp do_filter([head | tail], check, new_list) do
    if check.(head) do
      do_filter(tail, check, new_list ++ [head])
    else
      do_filter(tail, check, new_list)
    end
  end


  ## split
  def split(list, count) when count < 0 do
    do_split(list, length(list) + count, {[],[]})
  end

  def split(list, count) do
    do_split(list, count, {[],[]})
  end

  defp do_split([], _, split_list) do
    split_list
  end

  defp do_split([head | tail], count, {first_half, second_half}) when length(first_half) < count do
    do_split(tail, count, {first_half ++ [head], second_half})
  end

  defp do_split([head | tail], count, {first_half, second_half}) when length(first_half) == count or count <= 0 do
    do_split(tail, count, {first_half, second_half ++ [head]})
  end


  ## take
  def take(list, count) do
    do_take(list, count, [])
  end

  defp do_take([], _, new_list) do
    new_list
  end

  defp do_take(_, count, new_list) when length(new_list) >= count do
    new_list
  end

  defp do_take([head | tail], count, new_list) when length(new_list) < count do
    do_take(tail, count, new_list ++ [head])
  end

end
