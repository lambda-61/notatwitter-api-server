defmodule NotatwitterWeb.Auth.SessionController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.Auth

  action_fallback NotatwitterWeb.ErrorController

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user, token} <- Auth.Session.authenticate(username, password) do
      conn
      |> CookieToJwtPlug.put_session_token(token)
      |> render("show.json", user: user, token: token)
    end
  end

  def session(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end
end
