### Chapter 7 - Lists and recursion

1\. Write a _mapsum_ function that takes a list and a function.  It applies the function to each element of the list and then sums the result, so: `MyList.mapsum [1,2,3], &(&1 * &1) => 14`

```elixir
defmodule MyList do
  def mapsum(list, func) do
    do_mapsum(list, func, 0)
  end

  defp do_mapsum([head | []], func, acc), do: acc + func.(head)

  defp do_mapsum([head | tail], func, acc) do
    do_mapsum(tail, func, acc + func.(head))
  end

end
```
---
2\. Write a `max(list)` that returns the element with the maximum value in the list.  (This is slightly trickier than it sounds.)

```elixir
defmodule MyList do
  def max(list = [head | _tail]), do: do_max(list, head)

  defp do_max([], current), do: current
  defp do_max([head | tail], current) when head > current, do: do_max(tail, head)
  defp do_max([_head | tail], current), do:  do_max(tail, current)
end
```
> Note the clever use of pattern matching to create 2 variables that can be used separately in the first method definition!  This could have easily been written `def max([head | tail]), do: _max([head | tail], head)`

---
3\. An Elixir single-quoted string is actually a list of individual character codes.  Write a `caesar(list, n)` function that adds _n_ to each list element, wrapping if the addition results in a character greater than _z_.
`iex> MyList.caesar('ryvkve', 13)`

```elixir
defmodule MyList do
  def caesar([], _), do: []
  def caesar([head | tail], shift) do
    [ shift_letter(head, shift) | caesar(tail, shift)]
  end

  defp shift_letter(letter, shift) when letter + shift > 122, do: (letter + shift) - 26
  defp shift_letter(letter, shift), do: letter + shift
end
```
> Note the interesting way of building a returned array by using `[orig | append ]`

---
4\. Write a function `MyList.span(from, to)` that returns a list of the numbers from `from` to `to`.
```elixir
defmodule MyList do
  def span(from, to), do: do_span(from, to)
  defp do_span(from, to) when from <= to, do: [ from | do_span(from+1, to) ]
  defp do_span(_,_), do: []
end
```
