list = [1, [[2], 3]]

list
|> List.flatten
|> Enum.reverse
|> Enum.map(fn(n) -> n * n end)
|> IO.inspect

IO.inspect(Enum.map(Enum.reverse(List.flatten(list)), fn(n) -> n * n end))