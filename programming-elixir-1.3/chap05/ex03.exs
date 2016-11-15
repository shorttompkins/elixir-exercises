fizzbuzz = fn
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,c) -> c
end

fuzzer = fn (n) -> fizzbuzz.(rem(n,3), rem(n,5), n) end

IO.puts fuzzer.(10)
IO.puts fuzzer.(11)
IO.puts fuzzer.(12)
IO.puts fuzzer.(13)
IO.puts fuzzer.(14)
IO.puts fuzzer.(15)
IO.puts fuzzer.(16)
