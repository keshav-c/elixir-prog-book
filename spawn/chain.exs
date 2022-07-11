defmodule Chain do
  @moduledoc """
  Enum.reduce(enum, acc, fn) applies fn x, acc -> something end to each element --- x --- of the
  enumerable enum.

  In Enum.reduce(1..n, self(), code_to_run) we are running a loop n times.
  Iter 1: code_to_run(1, self), spawns counter(self), waits to Rx n so Tx n+1 to self; acc set to pid1
  Iter 2: code_to_run(2, pid1), spawns counter(pid1), waits ------------------to pid1; acc set to pid2

  We start from:
    def counter(self()) do
      receive do
        n -> send(self(), n+1)
      end
    end

  So self receives the final accumulated value from the last counter process. This has to be spawned
  last counter process     = pid1 = spawn(Chain, :counter, [self()])
  penultimate counter proc = pid2 = spawn(Chain, :counter, [pid1])

  From the above pattern, we can see that it's better to use Enum.reduce to express this, with the pid
  as the accumulator.
  """

  def counter(next_pid) do
    receive do
      n ->
        send(next_pid, n + 1)
    end
  end

  def create_processes(n) do
    code_to_run = fn _, send_to ->
      spawn(Chain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), code_to_run)
    # the above will generate:
    # 1 <- 2 <- 3... <- n (last)

    # start the count by sending a 0 to the last process
    send(last, 0)

    receive do
      # The guard clause is needed because of a bug in some versions of Elixir. A residual
      # message is left lying around (which records process termination). We want to ignore
      # this residual and instead only respond to integer message
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    # timer to time the execution of create_processes
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect()
  end
end

# $ elixir -r chain.exs -e "Chain.run(10)"
# For more processes
# $ elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(400_000)"
