defmodule NotatwitterWeb.Auth.RegistrationController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias Notatwitter.Auth.UserManager

  action_fallback NotatwitterWeb.ErrorController

  def register(conn, params) do
    with {:ok, user} <- UserManager.create(params) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end
end
