# Use the span function from lists/ListsAndRecursion-4.enums and list comprehensions
# to return a list of prime numbers from 2 to n
defmodule MyList do
  def span(from, to) when from > to, do: []
  def span(from, to), do: [ from | span(from + 1, to) ]
end

defmodule Primes do
  def filter(n) do
    for x <- MyList.span(2, n),
      Enum.all?(divisors(x), fn e -> rem(x, e) != 0 end), do: x
  end

  defp divisors(n) do
    upper_lim = n |> :math.sqrt |> trunc
    MyList.span(1, upper_lim) -- [1]
  end
end

IO.inspect Primes.filter(100)

