defmodule Users do
  keshav = %{ name: "Keshav", state: "KA", likes: "programming" }
  case keshav do
    %{state: some_state} = person -> IO.puts "#{person.name} lives in #{some_state}"
    _ -> IO.puts "No matches"
  end
end

