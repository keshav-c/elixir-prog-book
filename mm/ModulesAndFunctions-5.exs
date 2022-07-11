# Recursive function to calculate GCD of 2 nonnegative integers

defmodule Math do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

