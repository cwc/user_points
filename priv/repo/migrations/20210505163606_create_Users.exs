defmodule UserPoints.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:Users) do
      add :points, :integer

      timestamps()
    end

  end
end
