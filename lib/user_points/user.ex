defmodule UserPoints.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :points]}
  schema "Users" do
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_points_range
  end

  @doc """
  Validates a user's points field in a changeset, ensuring points is in the range [0..100].
  """
  def validate_points_range(changeset) do
    validate_change(changeset, :points, fn f, v ->
      case v do
        x when x in 0..100 -> []
        _ -> [{f, "points must be in the range [0..100]"}]
      end
    end)
  end
end
