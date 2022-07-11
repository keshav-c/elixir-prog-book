# Ceasar ciper for lower case messages in single quotes. 'a' -> 97; 'z' -> 122
# iex renders string in '' as utf-8 bytes which can be processed as a list

defmodule MyList do
  defp add(c, offset), do: c + offset
  defp new_char(c) when c in 97..122, do: c
  defp new_char(c) when c > 122, do: 96 + rem(c - 122, 26)

  def caesar([], _offset), do: []
  def caesar([ f | r ], offset), do: [ f |> add(offset) |> new_char | caesar(r, offset) ]
end

