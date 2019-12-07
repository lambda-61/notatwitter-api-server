defmodule NotatwitterWeb.Auth.SessionController do
  @moduledoc false

  use NotatwitterWeb, :controller
  use PhoenixSwagger

  alias Notatwitter.Auth
  alias NotatwitterWeb.CommonSwagger
  alias NotatwitterWeb.Auth.SessionSwagger

  action_fallback NotatwitterWeb.ErrorController

  swagger_path :login do
    description("Login with credentials")
    SessionSwagger.login_parameters()
    response(200, "Ok", SessionSwagger.login_schema())
    response(401, "Invalid credentials")
  end

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user, token} <- Auth.Session.authenticate(username, password) do
      conn
      |> CookieToJwtPlug.put_session_token(token)
      |> render("show.json", user: user, token: token)
    end
  end

  swagger_path :session do
    description("Get info about current session")
    CommonSwagger.requires_authorization()
    response(200, "Ok", SessionSwagger.session_schema())
    response(401, "Not authorized")
  end

  def session(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end
end
