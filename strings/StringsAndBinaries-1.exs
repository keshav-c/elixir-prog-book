# Write a function that returns true if a single-quoted string contains only
# printable ASCII characters (space through tilde).
defmodule MyString do
  def check([]), do: true
  def check([ h | t ]) do
    _is_printable?(h) && check(t)
  end

  defp _is_printable?(c) do
    [ space | _ ] = ' '
    tilde = ?~
    printable_range = space..tilde
    c in printable_range
  end
end

IO.puts "'hello' is printable? #{MyString.check('hello')}"
IO.puts "'∂x/∂y' is printable? #{MyString.check('∂x/∂y')}"

