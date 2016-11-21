### Chapter 10 - Processing Collections -- Enum and Stream

```elixir
iex(1)> Enum.filter(1..10,&(rem(&1,2) == 0)
...(1)> )
[2, 4, 6, 8, 10]
iex(2)> Enum.filter(1..10,&(rem(&1,2) == 0))
[2, 4, 6, 8, 10]
iex(3)> Enum.filter(1..10,&(rem(&1,2) != 0))
[1, 3, 5, 7, 9]
iex(4)> Enum.filter(1..10,&(&1 > 2))
[3, 4, 5, 6, 7, 8, 9, 10]
iex(5)> require Integer
Integer
iex(6)> Enum.filter(1..10,&Integer.is_even/1)
[2, 4, 6, 8, 10]
iex(7)> Enum.filter(1..10,&Integer.is_odd/1)
[1, 3, 5, 7, 9]
iex(8)> Enum.sort(1..10)
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
iex(10)> Enum.sort(1..10, &(&2 < &1))
[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
```
> Note that the ranged passed as the first parameter acts as a natural enumerable list.  Would have worked with `list = Enum.to_list 1..10` as well ;)


1\. Implement the following `Enum` functions using no library functions or list comprehensions: `all?`, `each`, `filter`, `split`, and `take`.  You may need to use an `if` statement to implement `filter`.

```
see: ex01.exs
```
