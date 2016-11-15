defmodule Chap5 do

  def guess(actual, lo..hi) do
    number = _middle(lo..hi)
    IO.puts "Is it #{number}"
    _guess(actual, lo..hi, number)
  end

  defp _guess(actual, _, guess) when actual == guess, do: actual
  defp _guess(actual, lo.._, guess) when guess > actual do
    guess(actual, lo..guess-1)
  end
  defp _guess(actual, _..hi, guess) when guess < actual do
    guess(actual, guess+1..hi)
  end

  defp _middle(lo..hi) do
    div(hi-lo,2) + lo
  end

end
