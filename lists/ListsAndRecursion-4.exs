# function MyList.span(from, to) returns a list of the numbers from `from` up to `to`.
defmodule MyList do
  def span(from, to) when from > to, do: []
  def span(from, to), do: [ from | span(from + 1, to) ]
end

