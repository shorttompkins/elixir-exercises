defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1,
                             sort_into_ascending_order: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three values given" do
    assert parse_args(["shorttompkins", "elixir-exercises", "99"]) == { "shorttompkins", "elixir-exercises", 99 }
  end

  test "count is defaulted to 4 if not provided" do
    assert parse_args(["shorttompkins", "elixir-exercises" ]) == { "shorttompkins", "elixir-exercises", 4 }
  end

  test "sort list into ascending order" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(list) do
    for value <- list, do: %{"created_at" => value, "other_data": "xxx"}
  end


  

end
