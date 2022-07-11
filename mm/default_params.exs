defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

IO.puts "Example.func(\"a\", \"b\"): #{inspect Example.func("a", "b")}"
IO.puts "Example.func(\"a\", \"b\", \"c\"): #{inspect Example.func("a", "b", "c")}"
IO.puts "Example.func(\"a\", \"b\", \"c\", \"d\"): #{inspect Example.func("a", "b", "c", "d")}"

