# max(list) function returns the element with the maximum value in the list.
defmodule MyList do
  def max([ head | []]) when is_number(head), do: head
  def max([ head | [ th | tt ]]) when head > th, do: max([ head | tt ])
  def max([ head | [ th | tt ]]) when head < th, do: max([ th | tt ])
end

