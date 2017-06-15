defmodule Toy do
  def sum_list([]) do
    0
  end

  def sum_list([head | tail]) do
    sum_list(head) + sum_list(tail)
  end

  def sum_list(head) do
    head
  end
end

Toy.sum_list([1,2,3,4,5])
|> IO.puts