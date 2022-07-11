defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_)     -> "I don't know you"
    end
  end 
end

# This can be done anonymous functions as well

# for = fn name, greeting ->        
#   fn
#     (^name) -> "#{greeting} #{name}"
#     (_)     -> "I don't know you."  
#   end
# end

mr_chakravarthy = Greeter.for("Keshav", "Welcome")

IO.puts " When given \"Keshav\": #{mr_chakravarthy.("Keshav")}"
IO.puts " When given \"Yarou\": #{mr_chakravarthy.("Yarou")}"

