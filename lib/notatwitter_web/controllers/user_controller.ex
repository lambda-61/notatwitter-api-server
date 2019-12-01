defmodule NotatwitterWeb.UserController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.User.AccessPolicy
  alias Notatwitter.Users

  action_fallback NotatwitterWeb.ErrorController

  def index(conn, _) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.find_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def register(conn, params) do
    with {:ok, user} <- Users.register_user(params) do
      conn
      |> put_status(:created)
      |> render("registred.json", user: user)
    end
  end

  def update(conn, %{"id" => id} = params) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, user} <- Users.find_user(id),
         :ok <-
           Bodyguard.permit(AccessPolicy, :update_user, current_user, user),
         {:ok, user} <- Users.update_user(user, params) do
      render(conn, "updated.json", user: user)
    end
  end
end
