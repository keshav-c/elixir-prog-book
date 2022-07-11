# Implement the following Enum functions using no library functions or list comprehensions.
# all?, each, filter, split, and take.
defmodule MyEnum do
  def all?([], _func), do: true
  def all?([ head | tail ], func) when is_function(func, 1) do
    if func.(head),
    do: all?(tail, func),
    else: false
  end

  def each([], _func), do: :ok
  def each([ head | tail ], func) when is_function(func, 1) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []
  def filter([ head | tail ], func) when is_function(func, 1) do 
    if func.(head),
    do: [ head | filter(tail, func) ],
    else: filter(tail, func)
  end

  def split([], _n), do: { [], [] }
  def split(list = [ _h | _t ], n) when n == 0, do: { [], list }
  def split([ h | t ], n) when n > 0 do
    { first, second } = split(t, n - 1)
    { [h] ++ first, second }
  end
  def split(list = [ _h | _t ], n) when n < 0 do
    l = len(list)
    if -n >= l do
      { [], list }
    else
      split(list, l + n)
    end
  end

  def take([], _n), do: []
  def take(list = [ _h | _t ], n) when n >= 0 do
    { taken, _remaining } = split(list, n)
    taken
  end
  def take(list = [ _h | _t ], n) when n < 0 do
    { _remaining, taken } = split(list, n)
    taken
  end

  def flatten([]), do: []
  def flatten([ h | t ]) when not is_list(h), do: [ h | flatten(t) ]
  def flatten([ h | t ]) when is_list(h), do: flatten(h) ++ flatten(t)
  
  defp len([]), do: 0
  defp len([ _h | t]), do: 1 + len(t)
end

