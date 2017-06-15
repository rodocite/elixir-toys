defmodule Directory do
  def filter(path, extension) do
    path
    |> Path.join("**/*.#{extension}")
    |> Path.wildcard
  end
end

Directory.filter("./directory", "ex")
|> IO.inspect