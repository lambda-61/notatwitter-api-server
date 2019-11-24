defmodule NotatwitterWeb.ReplyController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.Users

  action_fallback NotatwitterWeb.ErrorController

  def index(conn, %{"post_id" => post_id}) do
    replies = Users.list_replies(post_id)
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"user_id" => user_id, "post_id" => post_id} = params) do
    # TODO!: Put user_id from the conn.
    with {:ok, reply} <- Users.create_reply(user_id, post_id, params) do
      conn
      |> put_status(:created)
      |> render("created.json", reply: reply)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, reply} <- Users.update_reply(id, params) do
      render(conn, "updated.json", reply: reply)
    end
  end
end
