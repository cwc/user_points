defmodule UserPoints.Engine do
  use GenServer, id: __MODULE__

  require Logger

  import Ecto.Query

  alias UserPoints.Repo
  alias UserPoints.User

  @update_interval_ms 60 * 1000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    Process.send_after(self(), :update, @update_interval_ms)

    {:ok, %{
      max_number: Enum.random(0..100),
      last_query: nil
    }}
  end

  @impl true
  def handle_info(:update, state) do
    Logger.info("Updating user points")

    # Update all user points in the DB with a random value from [0..100]
    case Ecto.Adapters.SQL.query(UserPoints.Repo, "UPDATE \"Users\" SET points = floor(random() * 101)") do
      {:error, err} -> Logger.error(err)
      _ -> :ok
    end

    Process.send_after(self(), :update, @update_interval_ms)

    new_state = Map.put(state, :max_number, Enum.random(0..100))

    Logger.info("New state: #{inspect(new_state)}")

    # Set new max_number
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:winning_users, _from, state) do
    time = DateTime.utc_now()

    # Get up to two users with more points than max_number
    users = Repo.all(from u in User, where: u.points > ^state.max_number, limit: 2)

    reply = %{users: users, timestamp: state.last_query}

    {:reply, reply, Map.put(state, :last_query, time)}
  end

  def get_winning_users do
    GenServer.call(__MODULE__, :winning_users)
  end
end
