defmodule FibSolver do
  # This is the fib server
  def fib(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:fib, n, client} ->
        send(client, {:answer, n, fib_calc(n), self()})
        fib(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      # The flow is this: When the scheduler gets a ready message from a fib-server
      # the top number in queue is sent to it to be calculated (fib value). In the scheduler
      # we don't keep track of which fib-server is occupied etc. The process is driven entirely
      # by the fib-server messages.
      {:ready, pid} when queue != [] ->
        [next | tail] = queue
        send(pid, {:fib, next, self()})
        schedule_processes(processes, tail, results)

      # when the to_process queue is empty, and a fib-server says it's ready for the next calculation
      # we send the shutdown signal to that fib-server. At this point, all calculation has been done
      # so shutdown signal is sent to any process that is remaining. If the fib-server is calculating a
      # value, then after it sends the result back to the scheduler, it goes into receiving mode and
      # then receives the shutdown signal that was sent to it, while it was busy calculating.
      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          # results are sorted because they are added in the order we get them
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      # On receiving an answer, the result is stored in the results array and the function is
      # recursively called with the current results
      {:answer, number, result, _pid} ->
        # results added in the order we get them
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

# to_calculate = List.duplicate(37, 20)
to_calculate = Enum.to_list(1..37)

Enum.each(1..10, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_calculate])

  if num_processes == 1 do
    IO.puts(inspect(result))
    IO.puts("\n #   time (s)")
  end

  :io.format("~2B     ~.2f~n", [num_processes, time / 1_000_000.0])
end)
