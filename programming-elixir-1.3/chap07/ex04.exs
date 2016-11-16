defmodule MyList do
  def span(from, to), do: _span(from, to)
  defp _span(from, to) when from <= to, do: [ from | _span(from+1, to) ]
  defp _span(_,_), do: []
end
