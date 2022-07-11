defmodule Canvas do
  @defaults [ fg: "black", bg: "white", font: "Merriweather" ]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Foreground:  #{options[:fg]}"                                      # merge keyword lists will overwrite existing options with new ones
    IO.puts "Background:  #{Keyword.get(options, :bg)}"                         # was set in defaults
    IO.puts "Font:        #{Keyword.get(options, :font)}"                       # was set in defaults
    IO.puts "Pattern:     #{Keyword.get(options, :pattern, "solid")}"           # uses default value when no option is found
    IO.puts "Style:       #{inspect Keyword.get_values(options, :style)}"       # get multiple value with the same keyword
  end
end

Canvas.draw_text("hello", fg: "red", style: "italic", style: "bold")

