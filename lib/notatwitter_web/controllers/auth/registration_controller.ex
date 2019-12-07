defmodule NotatwitterWeb.Auth.RegistrationController do
  @moduledoc false

  use NotatwitterWeb, :controller
  use PhoenixSwagger

  alias Notatwitter.Auth.UserManager
  alias NotatwitterWeb.Auth.RegistrationSwagger

  action_fallback NotatwitterWeb.ErrorController

  swagger_path :register do
    description("Register a new user")
    RegistrationSwagger.register_parameters()
    response(201, "Ok", RegistrationSwagger.register_schema())
    response(422, "Unprocessable entity")
  end

  def register(conn, params) do
    with {:ok, user} <- UserManager.create(params) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end
end
