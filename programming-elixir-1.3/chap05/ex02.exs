fizzbuzz = fn
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,c) -> c
end
IO.puts fizzbuzz.(1,2,3)
IO.puts fizzbuzz.(0,1,2)
IO.puts fizzbuzz.(1,0,99)
IO.puts fizzbuzz.(0,0,123123)
