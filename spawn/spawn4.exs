# Handling multiple messages -> Recursion
defmodule Spawn4 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
        # recursive step spins up another greeter
        # If last line in function is recursive call, then tail call optimization
        # will ensure stack is not overrun.
        greet()
    end
  end
end

# here's a client
pid = spawn(Spawn4, :greet, [])

send(pid, {self(), "World!"})

receive do
  {:ok, message} ->
    IO.puts(message)
end

send(pid, {self(), "Kermit!"})

receive do
  {:ok, message} ->
    IO.puts(message)
end

send(pid, {self(), "Jar Jar Beenks!"})

receive do
  {:ok, message} ->
    IO.puts(message)
end
