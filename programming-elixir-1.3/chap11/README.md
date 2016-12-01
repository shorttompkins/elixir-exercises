### Chapter 11 - Strings and Binaries

1\. Write a function that returns `true` if a single-quoted string contains only printable ASCII characters (space through tilde).
_Note_: space = 32, ~ = 126

```elixir
def printable(chars) do
  Enum.any?(chars, &(&1 >= 32 && &1 <= 126))
end
```

---

2\. Write an `anagram?(word1, word2)` that returns `true` if its parameters are anagrams.
_Note: anagram = a word, phrase, or name formed by rearranging the letters of another, such as cinema, formed from iceman._

```elixir
def anagram(word1, word2) do
  to_charlist(word1) |> Enum.sort == to_charlist(word2) |> Enum.sort
end
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

4\. (Hard) Write a function that takes a single-quoted string of the form _number[+-*/]number_ and returns the result of the calculation.  The individual numbers do not have leading plus or minus signs.
`calculate('123 + 27') # => 150`

```elixir
def calculate(problem) do
  problem_map = problem |> strip_spaces |> parse_problem

  case problem_map[:operator] do
    '+' -> problem_map[:first] + problem_map[:second]
    '-' -> problem_map[:first] - problem_map[:second]
    '*' -> problem_map[:first] * problem_map[:second]
    '/' -> problem_map[:first] / problem_map[:second]
    _ -> 0
  end
end

def strip_spaces(str) when is_list(str), do: _strip_spaces(str, [])
def strip_spaces(str), do: _strip_spaces(to_charlist(str), [])
defp _strip_spaces([], acc), do: acc
defp _strip_spaces([ head | tail ], acc) do
  if head == 32 do
    _strip_spaces(tail, acc)
  else
    _strip_spaces(tail, acc ++ [head])
  end
end

def parse_problem(problem) do
  { operator, operator_at } = _parse_operator(problem)
  first_half = _parse_first(problem, operator_at)
  last_half = _parse_second(problem, operator_at + 1)
  %{ first: first_half, operator: operator, second: last_half }
end

defp _parse_operator(problem) do
  operator_at = problem |> Enum.find_index(&(&1 == ?+ || &1 == ?- || &1 == ?* || &1 == ?/))
  {:ok, operator} = Enum.fetch(problem, operator_at)
  { [operator] ++ [], operator_at }
end
defp _parse_first(problem, until), do: Enum.take(problem, until) |> List.to_integer
defp _parse_second(problem, start), do: Enum.drop(problem, start) |> List.to_integer
```
> This problem turned out to be way more annoying than I would have thought.  Not sure I took the best approach, but hey it works!

---

5\. **Skipped**

---

6\. Write a function to capitalize the sentences in a string.  Each sentence is terminated by a period and a space.  Right now, the case of the characters in the string is random.
```
iex> capitalize_sentences("oh. a DOG. woof. ")
"Oh. A dog. Woof. "
```

```elixir
def capitalize_sentence(sentence) do
  sentence
  |> String.split(". ")
  |> Enum.map(&String.capitalize(&1))
  |> Enum.join(". ")
end
```
