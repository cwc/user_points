# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     UserPoints.Repo.insert!(%UserPoints.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias UserPoints.User

# Add 1,000,000 users to the DB
# insert_all is limited to 65535 params; we need to do 2 params per row, so we'll do 40 batches of 25,000
Enum.each(0..39, fn _ ->
  UserPoints.Repo.insert_all(User,
  for (_ <- 0..24_999) do
    %{inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
    updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}
  end)
end)
