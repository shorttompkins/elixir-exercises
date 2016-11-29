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

---
2\. In the last exercise of Chapter 7, _Lists and Recursion_, you wrote a `span` function.  Use it and list comprehensions to return a list of the prime numbers from 2 to _n_.

```elixir
defmodule MyList do
  def span(from, to), do: for n <- from..to, do: n

  def primes(n) do
    range = span(2, n)
    for number <- range, is_prime?(number), do: number
  end

  def is_prime?(2), do: true
  def is_prime?(num) do
    # can safely ignore 1 and num because they will always be 0 ;)
    Enum.all?(span(2, num-1), &(rem(num, &1) != 0))
  end
end
```
> Note the fancy newer way of creating the `span` function

---
3\. The Pragmatic Bookshelf has offices in Texas (TX) and North Carolina (NC), so we have to charge sales tax on orders shipped to these states. The rates can be expressed as a keyword list:

`tax_rates = [ NC: 0.075, TX: 0.08 ]`

Here's a list of orders:

```
orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00 ],
  [id: 124, ship_to: :OK, net_amount: 35.50 ],
  [id: 125, ship_to: :TX, net_amount: 24.00 ],
  [id: 126, ship_to: :TX, net_amount: 44.80 ],
  [id: 127, ship_to: :NC, net_amount: 25.00 ],
  [id: 128, ship_to: :MA, net_amount: 10.00 ],
  [id: 129, ship_to: :CA, net_amount: 102.00 ],
  [id: 130, ship_to: :NC, net_amount: 50.00 ]
]
```

Write a function that takes both lists and returns a copy of the orders, but with an extra field, `total_amount`, which is the net plus sales tax.  If a shipment is not to NC or TX, there's no tax applied.

```elixir
defmodule Chap10 do

  def orders_total(orders, tax_rates) do
    for order <- orders do
      total_amount = _calc_total(order[:net_amount], tax_rates[order[:ship_to]])
       order ++ [total_amount: total_amount]
    end
  end

  defp _calc_total(amount, nil), do: amount
  defp _calc_total(amount, rate), do: Float.round(amount * (1 + rate), 2)

end
```
