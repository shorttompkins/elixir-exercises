### Chapter 2 - Pattern Matching

1. Which of the following will match?
```elixir
a = [1,2,3] => [1,2,3]]
a = 4 => 4
4 = a => 4 (only after above, otherwise MatchError)
[a,b] = [1,2,3] => (MatchError) no match of right hand side value
a = [[1,2,3]] => [[1,2,3]]
[a] = [[1,2,3]] => [1,2,3]
[[a]] = [[1,2,3]] => (MatchError) no match of right hand side value
```

2. Which of the following will match?
```elixir
[a,b,c] = [1,2,3] => [1,2,3]
[a,b,a] = [1,1,2] => (MatchError)
[a,b,a] = [1,2,1] => [1,2,1]
```

3. The variable `a` is bound to the value `2`.  Which of the following will match?
```elixir
[a,b,a] = [1,2,3] => (MatchError)
[a,b,a] = [1,1,2] => (MatchError)
a = 1 => 1
^a = 2 => 2
^a = 1 => (MatchError) no match of right hand side value: 1
^a = 2 - a => (MatchError) no match of right hand side value: 0
```
> Have to remmeber that `^` will pin the value so that a reassignment will not occur.
