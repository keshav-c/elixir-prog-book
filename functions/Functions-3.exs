# This continues the FizzBuzz example from Functions-2:

fizzbuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

fizzbuzz_n = fn
  n -> fizzbuzz.(rem(n, 3), rem(n, 5), n)
end

IO.puts "10: #{fizzbuzz_n.(10)}"
IO.puts "11: #{fizzbuzz_n.(11)}"
IO.puts "12: #{fizzbuzz_n.(12)}"
IO.puts "13: #{fizzbuzz_n.(13)}"
IO.puts "14: #{fizzbuzz_n.(14)}"
IO.puts "15: #{fizzbuzz_n.(15)}"
IO.puts "16: #{fizzbuzz_n.(16)}"

