# Rewrite Enum.map [1,2,3,4], fn x -> x + 2 # using & notation

Enum.map [1, 2, 3, 4], &(&1 + 2)

# Rewrite Enum.each [1,2,3,4], fn x -> IO.inspect(x) # using & notation

Enum.each [1, 2, 3, 4], &IO.inspect/1

