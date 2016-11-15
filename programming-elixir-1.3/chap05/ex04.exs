prefix = fn (str) -> (fn (msg) -> str <> " " <> msg end) end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks!")
