defmodule GifForensics do
  def version(gif_file) do
    case File.read(gif_file) do
      {:ok, gif} -> 
        << gif_header :: binary-size(6), _ :: binary >> = gif
        IO.puts(gif_header)
      _ ->
        IO.puts("Couldn't open image.")
    end
  end
end

GifForensics.version("./sample.gif")