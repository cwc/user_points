# UserPoints

To start the server:

  * Install dependencies with `mix deps.get`
  * Verify that your Postgres connection details are correct in config/dev.exs
  * Create and migrate your database with `mix ecto.setup` (generating the users takes a bit)
  * `mix phx.server`

Navigate to or curl http://localhost:4000 to see the API response. Data is updated every 60 seconds.
