# Closure example:
# Outer takes a prefix and returns a function that appends prefix to given string.

prefix = fn p -> (fn g -> "#{p} #{g}" end) end

# Test:
mrs = prefix.("Mrs")
IO.puts "Expect \"Mrs. Smith\": #{mrs.("Smith")}"
IO.puts "Expect \"Elixir Rocks\": #{prefix.("Elixir").("Rocks")}"

