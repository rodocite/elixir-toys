defmodule ListModule do
  def flatten([]) do
    []
  end

  def flatten([head | tail]) do
    flatten(head) ++ flatten(tail)
  end

  def flatten(head) do
    [head]
  end
end

[1, 2, [3, 4, [5, 6, [7, 8]]]]
|> ListModule.flatten
|> IO.inspect
