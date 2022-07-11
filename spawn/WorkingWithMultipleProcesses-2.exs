defmodule MultiProc do
  import :timer, only: [sleep: 1]

  def simple_proc(sender, token, delay \\ 0) do
    sleep(delay)
    send(sender, token)
  end

  def main do
    spawn(MultiProc, :simple_proc, [self(), :fred, 50])
    spawn(MultiProc, :simple_proc, [self(), :betty, 100])

    Enum.each(1..2, fn _ ->
      receive do
        token when is_atom(token) ->
          IO.puts("Received #{inspect(token)}")
      end
    end)
  end
end

# run it in iex
