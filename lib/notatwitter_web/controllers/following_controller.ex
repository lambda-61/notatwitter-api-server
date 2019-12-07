defmodule NotatwitterWeb.FollowingController do
  @moduledoc false

  use NotatwitterWeb, :controller
  use PhoenixSwagger

  alias Notatwitter.Users
  alias NotatwitterWeb.{CommonSwagger, FollowingSwagger}

  action_fallback NotatwitterWeb.ErrorController

  swagger_path :follows do
    description("Users the specified user follows")
    CommonSwagger.requires_authorization()
    parameter(:user_id, :path, :integer, "")
    response(200, "Ok", FollowingSwagger.users_schema())
    response(401, "Unauthorized")
    response(404, "The user was not found")
  end

  def follows(conn, %{"user_id" => user_id}) do
    with {:ok, follows} <- Users.list_follows(user_id) do
      render(conn, "follows.json", follows: follows)
    end
  end

  swagger_path :followers do
    description("Users that follow the specified user")
    CommonSwagger.requires_authorization()
    parameter(:user_id, :path, :integer, "")
    response(200, "Ok", FollowingSwagger.users_schema())
    response(401, "Unauthorized")
    response(404, "The user was not found")
  end

  def followers(conn, %{"user_id" => user_id}) do
    with {:ok, followers} <- Users.list_followers(user_id) do
      render(conn, "followers.json", followers: followers)
    end
  end

  swagger_path :follow do
    description("Do follow the specified user")
    CommonSwagger.requires_authorization()
    parameter(:user_id, :path, :integer, "")
    response(200, "Ok", FollowingSwagger.follow_schema())
    response(401, "Unauthorized")
    response(404, "The user was not found")
  end

  def follow(conn, %{"user_id" => user_id}) do
    %{id: current_user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, _} <- Users.follow(current_user_id, user_id) do
      render(conn, "followed.json", %{})
    end
  end

  swagger_path :unfollow do
    description("Do unfollow the specified user")
    CommonSwagger.requires_authorization()
    parameter(:user_id, :path, :integer, "")
    response(200, "Ok", FollowingSwagger.unfollow_schema())
    response(401, "Unauthorized")
    response(404, "The user was not found")
  end

  def unfollow(conn, %{"user_id" => user_id}) do
    %{id: current_user_id} = Guardian.Plug.current_resource(conn)
    Users.unfollow(current_user_id, user_id)

    conn
    |> put_status(:no_content)
    |> render("unfollowed.json", %{})
  end
end
