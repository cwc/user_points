defmodule UserPointsWeb.ApiController do
  use UserPointsWeb, :controller

  def winning_users(conn, _params) do
    json(conn, UserPoints.Engine.get_winning_users())
  end
end
