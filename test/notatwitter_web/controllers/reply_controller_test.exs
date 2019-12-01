defmodule NotatwitterWeb.ReplyControllerTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase

  alias Notatwitter.Users

  setup %{conn: conn} do
    user = insert(:user, username: "user")
    {:ok, profile} = Users.find_user(user.id)
    {:ok, _} = Users.update_user(profile, %{avatar: base64_avatar()})
    post = insert(:post, user_id: user.id, text: "kek")
    reply = insert(:reply, post_id: post.id, user_id: user.id, text: "lol")
    [conn: as_user(conn, user), user: user, post: post, reply: reply]
  end

  describe "#index" do
    test "displays replies list", context do
      %{
        conn: conn,
        user: %{id: user_id, username: username},
        post: %{id: post_id}
      } = context

      conn =
        get(
          conn,
          Routes.user_post_reply_path(conn, :index, user_id, post_id)
        )

      assert [reply] = json_response(conn, 200)

      assert %{
               "id" => _,
               "user_id" => ^user_id,
               "username" => ^username,
               "avatar" => "http://localhost:4000/uploads" <> _,
               "created_at" => _,
               "text" => "lol"
             } = reply
    end
  end

  describe "#create" do
    test "creates a reply", context do
      %{conn: conn, user: %{id: user_id}, post: %{id: post_id}} = context

      conn =
        post(
          conn,
          Routes.user_post_reply_path(conn, :create, user_id, post_id),
          %{text: "lol"}
        )

      assert %{"text" => "lol"} = json_response(conn, 201)
    end
  end

  describe "#update" do
    test "updates a reply for a user", context do
      %{
        conn: conn,
        user: %{id: user_id},
        post: %{id: post_id},
        reply: %{id: id}
      } = context

      conn =
        patch(
          conn,
          Routes.user_post_reply_path(conn, :update, user_id, post_id, id),
          %{"text" => "lel"}
        )

      assert %{"text" => "lel"} = json_response(conn, 200)
    end

    test "cannot update a reply that does not belong to a current user", %{
      conn: conn,
      user: %{id: user_id},
      post: %{id: post_id}
    } do
      user = insert(:user)
      {:ok, reply} = Users.create_reply(user.id, post_id, %{"text" => "lil"})

      conn =
        patch(
          conn,
          Routes.user_post_reply_path(
            conn,
            :update,
            user_id,
            post_id,
            reply.id
          ),
          %{"text" => "lol"}
        )

      assert _ = json_response(conn, 401)
    end
  end

  defp base64_avatar do
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
  end
end
