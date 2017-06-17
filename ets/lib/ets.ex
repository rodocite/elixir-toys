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
        :record_not_found
      record ->
        [data | _] = record
        %{user => elem(data, 1)}
    end
  end

  def delete(user) do
    :ets.delete(:users, user)

    find(user)
    |> case do
      :record_not_found ->
        {:ok, "Record has been deleted"}
      _ ->
        {:error, "Something went wrong."}
    end
  end

  defp insert_records(json) do
    :ets.new(:users, [:set, :protected, :named_table])

    json["data"]
    |> Enum.each(fn record -> :ets.insert(:users, record) end)
  end
end