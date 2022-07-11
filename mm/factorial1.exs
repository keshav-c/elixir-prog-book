defmodule Factorial do
  def of(0), do: 1
  def of(n), do: n * of(n - 1)
end

IO.puts "Expect 3! = 6; #{Factorial.of(3)}"
IO.puts "Expect 7! = 5040; #{Factorial.of(7)}"
IO.puts "Expect 10! = 3628800; #{Factorial.of(10)}"

