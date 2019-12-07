defmodule NotatwitterWeb.UserController do
  @moduledoc false

  use NotatwitterWeb, :controller
  use PhoenixSwagger

  alias Notatwitter.User.AccessPolicy
  alias Notatwitter.Users
  alias NotatwitterWeb.{CommonSwagger, UserSwagger}

  action_fallback NotatwitterWeb.ErrorController

  swagger_path :index do
    description("Index users")
    CommonSwagger.requires_authorization()
    response(200, "Ok", UserSwagger.index_schema())
    response(401, "Unauthorized")
  end

  def index(conn, _) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  swagger_path :show do
    description("Show a user")
    CommonSwagger.requires_authorization()
    CommonSwagger.id_parameter()
    response(200, "Ok", UserSwagger.show_schema())
    response(404, "User was not found")
    response(401, "Unauthorized")
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.find_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  swagger_path :update do
    description("Update a user")
    CommonSwagger.requires_authorization()
    UserSwagger.update_parameters()
    response(200, "Ok", UserSwagger.show_schema())
    response(404, "User was not found")
    response(401, "Unauthorized")
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
