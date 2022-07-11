defmodule MyList do
  def reduce([], initial, _func), do: initial
  def reduce([ head | tail ], initial, func), do: reduce(tail, func.(head, initial), func)
end

