### Chapter 5 - Anonymous Functions

1\. Create and run the functions that do the following:
  - `list_concat.([:a,:b], [:c,:d]) => [:a,:b,:c,:d]`
```
iex> list_concat = fn (a,b) -> a ++ b end
iex> list_concat.([:a,:b], [:c,:d])
[:a,:b,:c,:d]
```
  - `sum.(1,2,3) => 6`
```
iex> sum = fn (a,b,c) -> a+b+c end
iex> sum.(1,2,3)
6
```
  - `pair_tuple_to_list.({1234,5678}) => [1234, 5678]`
```
iex> pair_tuple_to_list = fn({a,b}) -> [a,b] end
iex> pair_tuple_to_list.({1234,5678})
[1234,5678]
```
---
2\. Write a function that takes three arguments.  If the first two are zero, return "FizzBuzz".  If the first is zero, return "Fizz".  If the second is zero, return "Buzz".  Otherwise return the third argument.  Do not use any language features that we haven't covered in this book (so far).

```
fizzbuzz = fn
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,c) -> c
end

fizzbuzz.(1,2,3) => 3
fizzbuzz.(0,1,2) => "Fizz"
fizzbuzz.(1,0,99) => "Buzz"
fizzbuzz.(0,0,123123) => "FizzBuzz"
```
---
3\. The operator `rem(a,b)` returns the remainder after dividing `a` by `b`.  Write a function that takes a single integer (`n`) and calls the function in the previous exercise, passing it `rem(n, 3)`, and `n`.  Call it seven times with the arguments 10, 11, 12, and so on.  You should get "Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16.

```
fizzbuzz = fn
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,c) -> c
end

fuzzer = fn (n) -> fizzbuzz.(rem(n,3), rem(n,5), n) end

IO.puts fuzzer.(10)
IO.puts fuzzer.(11)
IO.puts fuzzer.(12)
IO.puts fuzzer.(13)
IO.puts fuzzer.(14)
IO.puts fuzzer.(15)
IO.puts fuzzer.(16)
```
> Very interesting "conditionless" approach to the classic FizzBuzz problem ;)

---
4\. Write a function `prefix` that takes a string.  It should return a new function that takes a second string.  When that second function is called, it will return a string containing the first string, a space, and the second string.

```
prefix = fn (str) -> (fn (msg) -> str <> " " <> msg end) end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks!")
```
---
5\. Use the `&` notation to rewrite the following:
  - `Enum.map [1,2,3,4], fn x -> x + 2 end`
  ```
  Enum.map [1,2,3,4], &(&1+2)
  [3, 4, 5, 6]
  ```
  - `Enum.each [1,2,3,4], fn x -> IO.inspect x end`
  ```
  Enum.each [1,2,3,4], &(IO.inspect(&1))  # ok, I guess
  Enum.each [1,2,3,4], &IO.inspect/1      # better!!
  1
  2
  3
  4
  :ok
  ```
