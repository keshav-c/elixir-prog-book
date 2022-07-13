defmodule Ticker do
  @moduledoc """
  First the start function is called which starts the Ticker.generator process and assigns
  it's PID to a global name -- :ticker. Client (Subscriber) processes can call Ticker.register
  and send their PID to Ticker.generator and receive notifications from it every 2 seconds.
  """

  # 2 seconds
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
    # => returns :yes
  end

  # Registration can also be done using the generator PID directly, but this is an interface that
  # hides the PID details (behind a name --- :ticker) from the clients.
  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  # start and register functions are not a part of the Ticker process. They can be called directly
  # when the module is loaded. So we have functions for both starting the process and providing an
  # external interface for it.

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        # go back to listening mode with new client registered
        generator([pid | clients])
    after
      @interval ->
        IO.puts("tick")

        Enum.each(clients, fn client ->
          send(client, {:tick})
        end)

        generator(clients)
    end
  end
end

defmodule Client do
  @moduledoc """
  Spawns a client process that receives a tick and puts a tock
  """
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock in client")
        receiver()
    end
  end
end

# Nodes-2: This Ticker sends out a tick only about every 2 seconds because if a new client
# is registered while said Ticker is waiting for a timeout, the countdown to 2s starts all
# over again.
