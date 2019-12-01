defmodule NotatwitterWeb.PostController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.User.AccessPolicy
  alias Notatwitter.Users

  action_fallback NotatwitterWeb.ErrorController

  def index(conn, %{"user_id" => user_id}) do
    posts = Users.list_posts(user_id)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"user_id" => user_id} = params) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, user} <- Users.find_user(user_id),
         :ok <-
           Bodyguard.permit(AccessPolicy, :create_post, current_user, user),
         {:ok, post} <- Users.create_post(user_id, params) do
      conn
      |> put_status(:created)
      |> render("created.json", post: post)
    end
  end

  def update(conn, %{"id" => id} = params) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, post} <- Users.find_post(id),
         :ok <-
           Bodyguard.permit(AccessPolicy, :update_post, current_user, post),
         {:ok, post} <- Users.update_post(post, params) do
      render(conn, "updated.json", post: post)
    end
  end
end
