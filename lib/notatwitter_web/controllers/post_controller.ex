defmodule NotatwitterWeb.PostController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.Users

  action_fallback NotatwitterWeb.ErrorController

  def index(conn, %{"user_id" => user_id}) do
    posts = Users.list_posts(user_id)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"user_id" => user_id} = params) do
    with {:ok, post} <- Users.create_post(user_id, params) do
      conn
      |> put_status(:created)
      |> render("created.json", post: post)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, post} <- Users.update_post(id, params) do
      render(conn, "updated.json", post: post)
    end
  end
end
