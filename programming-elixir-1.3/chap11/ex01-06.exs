defmodule Chap11 do
  def printable(chars) do
    Enum.any?(chars, fn(char) -> char >= 32 && char <= 126 end)
  end

  # --------------

  def anagram(word1, word2) do
    to_charlist(word1) |> Enum.sort == to_charlist(word2) |> Enum.sort
  end

  # --------------

  def calculate(problem) do
    problem_map = problem |> strip_spaces |> parse_problem

    case problem_map[:operator] do
      '+' -> problem_map[:first] + problem_map[:second]
      '-' -> problem_map[:first] - problem_map[:second]
      '*' -> problem_map[:first] * problem_map[:second]
      '/' -> div(problem_map[:first], problem_map[:second])
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


  # --------------

  def capitalize_sentence(sentence) do
    sentence
    |> String.split(". ")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(". ")
  end

end
