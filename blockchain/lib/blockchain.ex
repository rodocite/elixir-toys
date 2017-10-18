defmodule Blockchain do
  def start_link do
    blockchain = %{
      chain: [],
      current_transactions: [],
    }
    Agent.start_link(fn -> blockchain end, name: __MODULE__)
  end

  def new_block(previous_hash \\ nil) do
    current_state = Agent.get(__MODULE__, fn state -> state end)
    chain = current_state[:chain]
    last_index = length(chain)
    previous_block = Enum.fetch(chain, 0)

    IO.inspect(current_state)

    block = %{
        index: last_index + 1,
        timestamp: Time.utc_now,
        transactions: current_state.current_transactions,
        previous_hash: previous_hash || hash(previous_block)
    }

    __MODULE__ |>
    Agent.update(
      fn blockchain ->
        chain = blockchain[:chain]
        %{blockchain | chain: [] ++ chain ++ [block]}
      end
    )
  end

  def new_transaction(record) do
    record |>
    case do
      record ->
        __MODULE__ |>
        Agent.update(
          fn blockchain ->
            current_transactions = blockchain[:current_transactions]
            %{blockchain | current_transactions: [] ++ current_transactions ++ [record]}
          end
        )
    end
  end

  def hash({:ok, block}) do
    Agent.get(__MODULE__, fn state -> IO.inspect(state)end)
    :crypto.hmac(:sha256, "so secure, bro", Poison.encode!(block))
    |> Base.encode16
  end
end
