defmodule MyList do
  def span(from, to), do: do_span(from, to)
  defp do_span(from, to) when from <= to, do: [ from | do_span(from+1, to) ]
  defp do_span(_,_), do: []
end
