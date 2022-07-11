# Write a function to capitalize the sentences in a string. Each sentence is
# terminated by a period and a space. Right now, the case of the characters
# in the string is random.
# -----------------------
# iex> capitalize_sentences("oh. a DOG. woof. ")
# =>"Oh. A dog. Woof. "
# -----------------------
# Regex.scan(~r/.*\. /U, "Oh. A dog. Woof. ")                             
# =>[["Oh. "], ["A dog. "], ["Woof. "]]
# -----------------------
defmodule MyString do
  def capitalize_sentences(str), do: _process(String.next_codepoint(str))

  def _process(str_split, sentences \\ [], prev \\ "", sentence \\ "")
  def _process(nil, sentences, _, sentence) do
    (sentences ++ [sentence])
    |> Enum.map(&String.capitalize/1)
    |> Enum.join
  end
  def _process({ " ", rest }, sentences, ".", sentence) do
    _process(String.next_codepoint(rest), sentences ++ [sentence <> " "], "", "")
  end
  def _process({ cp, rest }, sentences, _, sentence) do
    _process(String.next_codepoint(rest), sentences, cp, sentence <> cp)
  end
end

