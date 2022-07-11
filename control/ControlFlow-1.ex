# Rewrite the FizzBuzz example using case.
defmodule FizzBuzz do
  def upto(n) when n > 0, do: _upto(1, n, [])

  defp _upto(_current, 0, result), do: Enum.reverse(result)
  defp _upto(current, left, result) do
    case %{r3: rem(current, 3), r5: rem(current, 5)} do
      %{r3: 0, r5: 0} -> _upto(current+1, left-1, [ "FizzBuzz" | result ])
      %{r3: 0}        -> _upto(current+1, left-1, [ "Fizz" | result ])
      %{r5: 0}        -> _upto(current+1, left-1, [ "Buzz" | result ])
      %{r3: _, r5: _} -> _upto(current+1, left-1, [ current | result ])
    end
  end
end

IO.inspect FizzBuzz.upto(50)

