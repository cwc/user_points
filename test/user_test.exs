defmodule UserPoints.UserTest do
  use ExUnit.Case

  alias UserPoints.User

  test "validates a good user changeset" do
    user = %User{}
    cs = User.changeset(user, %{points: 20})

    assert cs.valid?
  end

  test "invalidates changeset with invalid points" do
    user = %User{}
    cs = User.changeset(user, %{points: -20})

    assert !cs.valid?
    assert cs.errors[:points]
  end
end
