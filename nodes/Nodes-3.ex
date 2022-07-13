# Modify ticker program so that successive ticks are sent to the next client in the list
# In the book example whenever a new client is added, the counter restarts. This I mitigate here
# by having the countdown timer in a separate process and add the scheduler for new clients to a
# separate process
defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
    spawn(__MODULE__, :timer, [pid])
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  def timer(generator_pid) do
    receive do
    after
      @interval ->
        send(generator_pid, {:next})

        timer(generator_pid)
    end
  end

  def generator(clients) do
    receive do
      {:register, subscriber} ->
        clients = append_to_end(subscriber, clients)
        generator(clients)

      {:next} ->
        case clients do
          [] ->
            generator([])

          [client | waiting] ->
            send(client, {:tick})

            client
            |> append_to_end(waiting)
            |> generator()
        end
    end
  end

  # appends a value to the end of the list
  defp append_to_end(val, list) do
    list
    |> Enum.reverse()
    |> (&[val | &1]).()
    |> Enum.reverse()
  end
end

defmodule Client do
  def start(name) do
    pid = spawn(__MODULE__, :receiver, [name])
    Ticker.register(pid)
  end

  def receiver(name) do
    receive do
      {:tick} ->
        IO.puts("tock in #{name}: #{Calendar.strftime(DateTime.utc_now(), "%S:%f")}")
        receiver(name)
    end
  end
end
