defmodule UserPoints.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:Users) do
      add :points, :integer, default: 0, null: false

      timestamps()
    end

    # A user's points field must be in the range [0..100]
    create constraint("Users", "points_value_min", check: "points > -1")
    create constraint("Users", "points_value_max", check: "points < 101")
  end
end
