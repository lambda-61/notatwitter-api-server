defmodule NotatwitterWeb.FollowingController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.Users

  action_fallback NotatwitterWeb.ErrorController

  def follows(conn, %{"user_id" => user_id}) do
    with {:ok, follows} <- Users.list_follows(user_id) do
      render(conn, "follows.json", follows: follows)
    end
  end

  def followers(conn, %{"user_id" => user_id}) do
    with {:ok, followers} <- Users.list_followers(user_id) do
      render(conn, "followers.json", followers: followers)
    end
  end

  def follow(conn, %{"user_id" => user_id}) do
    %{id: current_user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, _} <- Users.follow(current_user_id, user_id) do
      render(conn, "followed.json", %{})
    end
  end

  def unfollow(conn, %{"user_id" => user_id}) do
    %{id: current_user_id} = Guardian.Plug.current_resource(conn)
    Users.unfollow(current_user_id, user_id)

    conn
    |> put_status(:no_content)
    |> render("unfollowed.json", %{})
  end
end
