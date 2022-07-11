# This is a FizzBuzz example:
# A function that accepts 3 arguments.
# - If the first 2 are 0, return "FizzBuzz".
# - If the first is 0, return "Fizz".
# - If the second is 0, return "Buzz".
# - Otherwise return the third argument.

fizzbuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

# Test:
IO.puts "expect FizzBuzz; Got: #{fizzbuzz.(0, 0, :something)}"
IO.puts "expect Fizz; Got: #{fizzbuzz.(0, 23, :something)}"
IO.puts "expect Buzz; Got: #{fizzbuzz.(32, 0, :something)}"
IO.puts "expect the third argument; Got: #{fizzbuzz.(32, 23, :"the third argument")}"

