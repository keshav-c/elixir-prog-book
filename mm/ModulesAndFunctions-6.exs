# Guessing game for number between 1 and 1000.

defmodule Chop do
  def mid(l..h) do
    div(l + h, 2)
  end
  def new_range(actual, range, guess) when actual < guess do
    l.._ = range
    l..guess
  end
  def new_range(actual, range, guess) when actual > guess do
    _..h = range
    guess..h
  end
  def new_range(actual, _, guess) when actual == guess do
    actual
  end
  def guess(actual, final) when is_integer(actual) and is_integer(final) and actual == final do
    IO.puts final
  end
  def guess(actual, l..h = range) when l < h and actual in l..h do
    IO.puts "Is it #{mid(range)}"
    guess(actual, new_range(actual, range, mid(range)))
  end
end

