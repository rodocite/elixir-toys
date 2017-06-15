defmodule FileReader do
  def read_file(file) do
    case File.read(file) do
      {:ok, f} ->
        IO.inspect(f)
        IO.puts("Finished reading file!")
      {:error, reason} ->
        IO.inspect(reason)
        IO.puts("Something went wrong.")
    end
  end
end

FileReader.read_file("./file.txt")