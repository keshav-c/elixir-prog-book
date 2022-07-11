# Write an anagram?(word1, word2) that returns true if its parameters are
# anagrams.
defmodule MyString do
  def anagram?(word1, word2) do
    Map.equal?(_to_dict(word1), _to_dict(word2))
  end

  defp _to_dict(str, dict \\ %{})
  defp _to_dict([], dict), do: dict
  defp _to_dict([ h | t ], dict) do
    if h in Map.keys(dict) do
      _to_dict(t, Map.put(dict, h, dict[h] + 1))
    else
      _to_dict(t, Map.put_new(dict, h, 1))
    end
  end
end

IO.puts "'hello' and 'loleh' are anagrams? #{MyString.anagram?('hello', 'loleh')}"
IO.puts "'what' and 'thaw' are anagrams? #{MyString.anagram?('what', 'thaw')}"
IO.puts "'colt' and 'dolt' are anagrams? #{MyString.anagram?('colt', 'dolt')}"

