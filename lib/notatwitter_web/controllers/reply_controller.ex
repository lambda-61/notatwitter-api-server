defmodule NotatwitterWeb.ReplyController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.User.AccessPolicy
  alias Notatwitter.Users
  alias NotatwitterWeb.{CommonSwagger, ReplySwagger}

  action_fallback NotatwitterWeb.ErrorController

  def index(conn, %{"post_id" => post_id}) do
    replies = Users.list_replies(post_id)
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"post_id" => post_id} = params) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, reply} <- Users.create_reply(user_id, post_id, params) do
      conn
      |> put_status(:created)
      |> render("created.json", reply: reply)
    end
  end

  def update(conn, %{"id" => id} = params) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, reply} <- Users.find_reply(id),
         :ok <-
           Bodyguard.permit(AccessPolicy, :update_reply, current_user, reply),
         {:ok, reply} <- Users.update_reply(reply, params) do
      render(conn, "updated.json", reply: reply)
    end
  end
end
