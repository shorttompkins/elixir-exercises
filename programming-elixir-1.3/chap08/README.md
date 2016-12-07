### Chapter 8 - Maps, Keyword Lists, Sets, and Structs


```elixir
$ iex
Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> new_map = %{:name => "Jason", :age => "39", :console => "Playstation 4", :food => "cheeseburger" }
%{age: "39", console: "Playstation 4", food: "cheeseburger", name: "Jason"}
iex(2)> new_map.age
"39"
## This wont work:
iex(3)> new_map["age"]
nil
## but this does:
iex(4)> new_map[:age]
"39"
## Note: cant add new key/values the same way you can update existing:
iex(5)> new_map = %{ new_map | :language, "elixir" }
** (SyntaxError) iex:5: syntax error before: '}'

iex(5)> new_map = %{ new_map | :food => "pizza" }
%{age: "39", console: "Playstation 4", food: "pizza", name: "Jason"}
iex(6)> new_map = %{ new_map | food:  "cheeseburger" }
%{age: "39", console: "Playstation 4", food: "cheeseburger", name: "Jason"}
iex(7)> new_map = Map.put_new(new_map, :game, "Bayonetta")
%{age: "39", console: "Playstation 4", food: "cheeseburger", game: "Bayonetta",
  name: "Jason"}
iex(8)> other_map = %{"name": "Jason", "console": "Playstation 4", "game": "Bayonetta"}
%{console: "Playstation 4", game: "Bayonetta", name: "Jason"}
```
> Note how you can mix/match using atom style syntax `:atom => value` or quoted key/value pairs `"atom" : "value"`

```elixir
iex(9)> Map.keys(new_map)
[:age, :console, :food, :game, :name]
iex(10)> new_map |> Map.values
["39", "Playstation 4", "cheeseburger", "Bayonetta", "Jason"]
```

Needed a version of `Map.take` (before realizing that it existed) so wrote the following:
```elixir
  def take(list, fields), do: Enum.map(list, &(_take &1, fields, %{}))
  defp _take(_item, [], new_map), do: new_map
  defp _take(item, [head|tail], new_map) do
    _take item, tail, Map.put_new(new_map, head, Map.get(item, head))
  end
```

#### Pattern Matching:
```elixir
iex(11)> %{ food: food } = new_map
%{age: "39", console: "Playstation 4", food: "cheeseburger", game: "Bayonetta",
  name: "Jason"}
iex(12)> food
"cheeseburger"
iex(13)> %{:age => 20} = new_map
** (MatchError) no match of right hand side value: %{age: "39", console: "Playstation 4", food: "cheeseburger", game: "Bayonetta", name: "Jason"}
## Check for existance of keys:
iex(13)> %{food: _, age: _} = new_map
%{age: "39", console: "Playstation 4", food: "cheeseburger", game: "Bayonetta",
  name: "Jason"}
iex(14)> %{height: _} = new_map
** (MatchError) no match of right hand side value: %{age: "39", console: "Playstation 4", food: "cheeseburger", game: "Bayonetta", name: "Jason"}

iex(14)> people = [
...(14)> %{name: "Grumpy", height: 1.24},
...(14)> %{name: "Dave", height: 1.88},
...(14)> %{name: "Dopey", height: 1.32},
...(14)> %{name: "Shaq", height: 2.16}]
[%{height: 1.24, name: "Grumpy"}, %{height: 1.88, name: "Dave"}, %{height: 1.32, name: "Dopey"}, %{height: 2.16, name: "Shaq"}]
iex(16)> for person = %{height: height} <- people, height > 1.5, do: person
[%{height: 1.88, name: "Dave"}, %{height: 2.16, name: "Shaq"}]
```

#### Structs:
```elixir
defmodule Person do
  defstruct name: "", age: 0, game: "", food: ""
end

iex(21)> newer_map = %Person{name: "Jason"}
%Person{age: 0, food: "", game: "", name: "Jason"}
iex(22)> newer_map = %Person{name: "Jason", age: 39, game: "Bayonetta"}
%Person{age: 39, food: "", game: "Bayonetta", name: "Jason"}
iex(23)> newer_map = %Person{newer_map | food: "pizza"}
%Person{age: 39, food: "pizza", game: "Bayonetta", name: "Jason"}
iex(24)> newer_map
%Person{age: 39, food: "pizza", game: "Bayonetta", name: "Jason"}
```
