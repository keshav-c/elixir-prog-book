defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n), do: n * 3

  def quadruple(n), do: double(double(n))
end

# Test

IO.puts "Expect 10; #{Times.double(5)}"
IO.puts "Expect 15; #{Times.triple(5)}"
IO.puts "Expect 20; #{Times.quadruple(5)}"

