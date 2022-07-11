# We now have the sales information in a file of comma-separated id, ship_to,
# and amount values in orders.csv
# Write a function that reads and parses this file and then passes the result
# to the sales_tax function. Remember that the data should be formatted into
# a keyword list, and that the fields need to be the correct types (so the id
# field is an integer, and so on).
defmodule Tax do
  def read_csv(filename) do
    with {:ok, file} = File.open(filename, [:read, :utf8])
    do
      # This bit reads the first header line and moves file ptr down
      header = IO.read(file, :line)
        |> String.split(",")
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.to_atom/1)
      # This bit reads the text data in file line by line and transforms it
      data = IO.stream(file, :line)
        |> Stream.map(&String.trim/1)
        |> Stream.map(&(String.split(&1, ",")))
        |> Stream.map(&(Enum.zip(header, &1)))
        |> Stream.map(&_parse_columns/1)
        |> Enum.to_list
      :ok = File.close(file)
      data
    end
  end

  def calc(orders, rates) do
    for order <- orders do
      amount = Keyword.get(order, :net_amount)
      destination = Keyword.get(order, :ship_to)
      rate = Keyword.get(rates, destination, 0)
      total = amount + (amount * rate)
      Keyword.put(order, :total_amount, total)
    end
  end
  
  defp _parse_columns(row) do
    row
      |> Keyword.update(:id, nil, fn v -> String.to_integer(v) end)
      |> Keyword.update(:ship_to, nil,
        fn v -> v |> String.replace(":", "") |> String.to_atom end)
      |> Keyword.update(:net_amount, nil, fn v -> String.to_float(v) end)
  end
end

rates = [ NC: 0.075, TX: 0.08 ]
IO.inspect Tax.read_csv("orders.csv") |> Tax.calc(rates)

