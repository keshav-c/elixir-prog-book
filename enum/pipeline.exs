[1, 2, 3, 4, 5]
|> IO.inspect(label: '01')
|> Enum.map(&(&1*&1))
|> IO.inspect(label: '02')
|> Enum.with_index
|> IO.inspect(label: '03')
|> Enum.map(fn {value, index} -> value - index end)
|> IO.inspect(label: '04')

