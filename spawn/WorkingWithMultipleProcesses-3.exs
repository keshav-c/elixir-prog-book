defmodule LinkEx1 do
  import :timer, only: [sleep: 1]

  def simple_proc(sender) do
    msg = "Hello from #{inspect(self())}!"
    send(sender, msg)
    # exit("#{inspect(self())} is done!")
    raise "#{inspect(self())} is done."
  end

  def run do
    IO.puts("Starting at #{inspect(self())}")
    rec = spawn_link(LinkEx1, :simple_proc, [self()])
    IO.puts("Just spawn linked #{inspect(rec)}")
    sleep(500)

    rx_code = fn _ ->
      receive do
        msg ->
          IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
      end
    end

    Enum.each(1.10, rx_code)
  end
end

LinkEx1.run()
