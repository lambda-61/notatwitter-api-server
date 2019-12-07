defmodule NotatwitterWeb.ReplyController do
  @moduledoc false

  use NotatwitterWeb, :controller
  use PhoenixSwagger

  alias Notatwitter.User.AccessPolicy
  alias Notatwitter.Users
  alias NotatwitterWeb.{CommonSwagger, ReplySwagger}

  action_fallback NotatwitterWeb.ErrorController

  swagger_path :index do
    description("List replies of the post")
    parameter(:post_id, :path, :integer, "")
    CommonSwagger.requires_authorization()
    response(200, "Ok", ReplySwagger.index_schema())
    response(401, "Unauthorized")
    response(404, "Post was not found")
  end

  def index(conn, %{"post_id" => post_id}) do
    replies = Users.list_replies(post_id)
    render(conn, "index.json", replies: replies)
  end

  swagger_path :create do
    description("Create a reply")
    parameter(:post_id, :path, :integer, "")
    CommonSwagger.requires_authorization()
    ReplySwagger.creation_parameters()
    response(201, "Created", ReplySwagger.show_schema())
    response(404, "Post was not found")
    response(422, "Unprocessable entity")
  end

  def create(conn, %{"post_id" => post_id} = params) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, reply} <- Users.create_reply(user_id, post_id, params) do
      conn
      |> put_status(:created)
      |> render("created.json", reply: reply)
    end
  end

  swagger_path :update do
    description("Update a reply")
    CommonSwagger.requires_authorization()
    CommonSwagger.id_parameter()
    ReplySwagger.creation_parameters()
    response(200, "Ok", ReplySwagger.show_schema())
    response(401, "Unauthorized")
    response(404, "Post with such an id for current user does not exist")
    response(422, "Unprocessable entity")
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
