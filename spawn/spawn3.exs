# Handling multiple messages -> Exit on timeout
defmodule Spawn3 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
    end
  end
end

# here's a client
pid = spawn(Spawn3, :greet, [])

send(pid, {self(), "World!"})

receive do
  {:ok, message} ->
    IO.puts(message)
end

send(pid, {self(), "Kermit!"})

# this second recieve will time out.
receive do
  {:ok, message} ->
    IO.puts(message)
after
  # timeout is 3000ms
  3000 ->
    IO.puts("The greeter has gone away")
end
