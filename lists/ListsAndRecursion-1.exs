# mapsum function takes a list and a function. It applies the function to each element of the list
# and then sums the result.
defmodule MyList do
  defp map([], _func), do: []
  defp map([ head | tail ], func), do: [ func.(head) | map(tail, func)]
  defp sum([]), do: 0
  defp sum([ head | tail ]), do: head + sum(tail)

  def mapsum(list, func), do: list |> map(func) |> sum
end

