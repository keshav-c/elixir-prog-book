# Handling multiple messages
defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
    end
  end
end

# here's a client
pid = spawn(Spawn2, :greet, [])

send(pid, {self(), "World!"})

receive do
  {:ok, message} ->
    IO.puts(message)
end

send(pid, {self(), "Kermit!"})

# this second recieve will hang because greet exits after dealing with the
# first send. The second send is not received at all.
receive do
  {:ok, message} ->
    IO.puts(message)
end
