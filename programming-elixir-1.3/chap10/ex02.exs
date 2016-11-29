defmodule MyList do
  def span(from, to), do: for n <- from..to, do: n

  def primes(n) do
    range = span(2, n)
    for number <- range, is_prime?(number), do: number
  end

  def is_prime?(2), do: true
  def is_prime?(num) do
    # can safely ignore 1 and num because they will always be 0 ;)
    Enum.all?(span(2,num-1), &(rem(num, &1) != 0))
  end
end
