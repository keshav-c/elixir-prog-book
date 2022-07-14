# Modify ticker program so that ticker is run as a ring of clients. A client pings next client in
# the ring. Like in Nodes-3 we must deal with the case where a client is added to the ring
# just as the 2 second interval is ending.

defmodule Tracker do
  @name :tracker

  def start do
    pid = spawn(__MODULE__, :track, [[]])
    :global.register_name(@name, pid)
  end

  def register(client) do
    send(:global.whereis_name(@name), {:register, client})
  end

  def track(clients) do
    receive do
      {:register, client} ->
        # IO.puts("got request to add #{inspect(client)}")

        if clients != [] do
          last = List.last(clients)
          first = List.first(clients)
          send(last, {:next, client})
          send(client, {:next, first})
          clients = append_to_end(client, clients)
          track(clients)
        else
          send(client, {:ping})
          track([client])
        end
    end
  end

  defp append_to_end(val, list) do
    list
    |> Enum.reverse()
    |> (&[val | &1]).()
    |> Enum.reverse()
  end
end

defmodule Client do
  import :timer, only: [sleep: 1]

  @interval 2000

  def start(name) do
    clock_pid = spawn(__MODULE__, :clock, [])
    pid = spawn(__MODULE__, :reciever, [name, clock_pid])
    Tracker.register(pid)
  end

  def reciever(name, clock_pid, next \\ self()) do
    receive do
      {:tick} ->
        IO.puts("tick in #{name}: #{Calendar.strftime(DateTime.utc_now(), "%S:%f")}")
        send(next, {:ping})
        reciever(name, clock_pid, next)

      {:ping} ->
        # IO.puts("#{name} got ping")
        send(clock_pid, {:start, self()})
        reciever(name, clock_pid, next)

      {:next, pid} ->
        reciever(name, clock_pid, pid)
    end
  end

  def clock() do
    receive do
      {:start, rx_pid} ->
        # IO.puts("wait for 2s")
        sleep(@interval)
        send(rx_pid, {:tick})
        clock()
    end
  end
end
