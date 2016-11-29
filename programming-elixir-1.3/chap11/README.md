### Chapter 11 - Strings and Binaries

1\. Write a function that returns `true` if a single-quoted string contains only printable ASCII characters (space through tilde).
_Note_: space = 32, ~ = 126

```elixir

```

---

2\. Write an `anagram?(word1, word2)` that returns `true` if its parameters are anagrams.
_Note: anagram = a word, phrase, or name formed by rearranging the letters of another, such as cinema, formed from iceman._

```elixir

```

---

3\. Try the following in IEx:
```
iex> [ 'cat' | 'dog' ]
['cat',100,111,103]
```
Why does iex print `'cat'` as a string, but `'dog'` as individual numbers?

**Because [ head | tail ] takes the first item in a list, and the remaining items in the list.  Therefore, `head` would be a single item (even though itself is a List).**

---

4\. (Hard) Write a function tha ttakes a single-quoted string of the form _number[+-*/]number_ and returns the result of the calculation.  The individual numbers do not have leading plus or minus signs.
`calculate('123 + 27') # => 150`

```elixir

```
