### Chapter 6 - Modules and Named Functions

```
defmodule Times do
  def double(n), do: n * 2
end
```

1\. Extend the `Times` module with a `triple` function that multiplies its parameter by three.

```
defmodule Times do
  def double(n), do: n * 2
  def triple(n) do
    n * 3
  end
end
```
---
2\. Run the result in iex. Use both techniques to compile the file.

```
$ iex "ex01-03.exs"
iex> Times.double(2)
4
iex> c("ex01-03.exs")
warning: redefining module Times (current version defined in memory)
  ex01-03.exs:1

[Times]

iex> import Times
iex> double(6)
12
```
---
3\. Add a `quadruple` function.  (Maybe it could call the `double` function...)

```
def quadruple(n) do
  double(n) * 2
end
```

```
iex> quadruple(10)
40
```
---
4\. Implement and run a function `sum(n)` that uses recursion to calculate the sum of the integers from 1 to _n_. (Write code in separate .exs file and load using iex.)

```
defmodule Chap6 do
  def sum(n), do: _sum(n, 0)

  defp _sum(0, acc), do: acc
  defp _sum(n, acc), do: _sum(n-1, acc + n)
end
```
```
iex> Chap6.sum(10)
55
```
---
5\. Write a function `gcd(x,y)` that finds the greatest common divisor between two nonnegative integers.  Algebraically, _gcd(x,y)_ is _x_ if _y_ is zero; it's _gcd(y,rem(x,y))_ otherwise.

```
defmodule Chap6 do
  def gcd(x, 0), do: x
  def gcd(x, y) do
    gcd(y, rem(x,y))
  end
end
```
```
iex> Chap6.gcd(8,12)
4
```
---
6\. _I'm thinking of a number between 1 and 1000..._

The most efficient way to find the number is to guess halfway between the low and high numbers of the range.  If our guess is too big, then answer lies between the bottom of the range and one less than our guess. If our guess is too small, then the answer lies between one more than our guess and the end of the range.

Your API will be `guess(actual, range)`, where `range` is an Elixir range.

Output should look similar to:
```
iex> Chap6.guess(273,1..1000)
Is it 500
Is it 250
Is it 375
Is it 312
Is it 281
Is it 265
Is it 273
273
```

```
defmodule Chap6 do

  def guess(actual, lo..hi) do
    number = _middle(lo..hi)
    IO.puts "Is it #{number}"
    _guess(actual, lo..hi, number)
  end

  defp _guess(actual, _, guess) when actual == guess, do: actual
  defp _guess(actual, lo.._, guess) when guess > actual do
    guess(actual, lo..guess-1)
  end
  defp _guess(actual, _..hi, guess) when guess < actual do
    guess(actual, guess+1..hi)
  end

  defp _middle(lo..hi) do
    div(hi-lo,2) + lo
  end

end
```
