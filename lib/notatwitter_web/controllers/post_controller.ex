defmodule NotatwitterWeb.PostController do
  @moduledoc false

  use NotatwitterWeb, :controller
  use PhoenixSwagger

  alias Notatwitter.User.AccessPolicy
  alias Notatwitter.Users
  alias NotatwitterWeb.{CommonSwagger, PostSwagger}

  action_fallback NotatwitterWeb.ErrorController

  swagger_path :index do
    description("Posts of the user")
    parameter(:user_id, :path, :integer, "")
    CommonSwagger.requires_authorization()
    response(200, "Ok", PostSwagger.index_schema())
    response(401, "Unauthorized")
    response(404, "User was not found")
  end

  def index(conn, %{"user_id" => user_id}) do
    posts = Users.list_posts(user_id)
    render(conn, "index.json", posts: posts)
  end

  swagger_path :create do
    description("Create a post for current user")
    CommonSwagger.requires_authorization()
    PostSwagger.creation_parameters()
    response(201, "Created", PostSwagger.show_schema())
    response(401, "Unauthorized")
    response(422, "Unprocessable entity")
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, post} <- Users.create_post(current_user.id, params) do
      conn
      |> put_status(:created)
      |> render("created.json", post: post)
    end
  end

  swagger_path :update do
    description("Update a post")
    PostSwagger.update_parameters()
    response(200, "Ok", PostSwagger.show_schema())
    response(404, "Post with such an id for current user was not found")
    response(401, "Unauthorized")
    response(422, "Unprocessable entity")
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
