defmodule Parallel do
  def pmap(collection, fun) do
    me = self()

    collection
    |> Enum.map(fn elem ->
      spawn_link(fn -> send(me, {self(), fun.(elem)}) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} -> result
      end
    end)
  end
end

# why pin operator? when we use ^pid, the map iteration waits till message recieved with the same
# pid as in the left side of the ->. If instead we used _pid, the first returned message would be
# assigned to the result.
