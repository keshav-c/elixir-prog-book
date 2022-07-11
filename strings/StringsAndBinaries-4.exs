# Write a function that takes a single-quoted string of the form
# number [+-*/] number and returns the result of the calculation. 
# The individual numbers do not have leading plus or minus signs.
# calculate('123 + 27') # => 150
defmodule MyString do
  def calculate(str) do
    _calculate_values(str)
  end

  defp _calculate_values(str, num1 \\ 0, op \\ nil, num2 \\ 0)
  defp _calculate_values([], num1, op, num2), do: _calculate_result(num1, op, num2)
  defp _calculate_values([ h | t ], num1, op, num2)
  when h in '0123456789' and op in '+-/*' do
    _calculate_values(t, num1, op, num2*10 + h - ?0)
  end
  defp _calculate_values([ h | t ], num1, nil, num2)
  when h in '0123456789' do
    _calculate_values(t, num1*10 + h - ?0, nil, num2)
  end
  defp _calculate_values([ h | t ], num1, op, num2) when h == ?\s do
    _calculate_values(t, num1, op, num2)
  end
  defp _calculate_values([ h | t ], num1, nil, num2) when h in '+-/*' do
    _calculate_values(t, num1, h, num2)
  end

  def _calculate_result(num1, ?+, num2), do: num1 + num2
  def _calculate_result(num1, ?-, num2), do: num1 - num2
  def _calculate_result(num1, ?*, num2), do: num1 * num2
  def _calculate_result(num1, ?/, num2), do: num1 / num2
end

