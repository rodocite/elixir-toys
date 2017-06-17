defmodule Users do

  @users_json "./lib/ets.json"

  def hydrate_ets do
    @users_json
    |> File.read
    |> case do
      {:ok, file} ->
        file
        |> Poison.decode!
        |> insert_records
      _ ->
        IO.puts("Could not read file.")
    end
  end

  def find(user) do
    :ets.lookup(:users, user)
    |> case do
      [] -> 
        {:error, "Could not find record."}
      record ->
        [data | _] = record
        %{user => elem(data, 1)}
    end
  end

  def delete(user) do
    :ets.delete(:users, user)
    |> IO.inspect
  end

  defp insert_records(json) do
    :ets.new(:users, [:set, :protected, :named_table])

    json["data"]
    |> Enum.each(fn record -> :ets.insert(:users, record) end)
  end
end