defmodule Users do

  @users_json "./lib/ets.json"

  def hydrate_ets do
    @users_json
    |> File.read
    |> case do
      {:ok, file} ->
        file
        |> Poison.decode!
        |> insert_data
      _ ->
        IO.puts("Could not read file.")
    end
  end

  def find(user) do
    [record | _] = :ets.lookup(:users, user)
    record
  end

  defp insert_data(json) do
    :ets.new(:users, [:set, :protected, :named_table])

    json["data"]
    |> Enum.each(fn record -> :ets.insert(:users, record) end)
  end
end