defmodule Spawn1 do
  def greet do
    receive do
      {sender, name} ->
        send(sender, {:ok, "Hello, #{name}"})
    end
  end
end

# here's a client
pid = spawn(Spawn1, :greet, [])
send(pid, {self(), "World!"})

receive do
  {:ok, message} ->
    IO.puts(message)
end
