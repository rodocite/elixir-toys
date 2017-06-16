defmodule PingPong do

  def ping do
    receive do
      :ping ->
        IO.puts("pong")
    end
  end

  def pong do
    receive do
      :pong ->
        IO.puts("ping")
    end
  end
end

#ping = spawn(PingPong, :ping, [])
#send(ping, :ping)

#=> pong