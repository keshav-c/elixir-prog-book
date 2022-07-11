# Write a function that takes a list of double-quoted strings and prints each
# on a separate line, centered in a column that has the width of the longest
# string. Make sure it works with UTF characters.
# iex> center(["cat", "zebra", "elephant"])
#   cat
#  zebra
# elephant
defmodule MyString do
  def center(list) do
    padded_len = _list_width(list)
    _print(list, padded_len)
  end

  defp _print([], _), do: :ok
  defp _print([ head | tail ], padded_len) do
    extra_len = padded_len - String.length(head)
    left_pad = String.length(head) + div(extra_len, 2)
    head
    |> String.pad_leading(left_pad)
    |> String.pad_trailing(padded_len)
    |> IO.puts
    _print(tail, padded_len)
  end

  defp _list_width(l) when is_list(l) do
    l |> Enum.map(&String.length/1) |> Enum.max
  end
end

