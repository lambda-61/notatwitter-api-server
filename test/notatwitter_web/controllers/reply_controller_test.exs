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

      conn = get(conn, Routes.post_reply_path(conn, :index, post_id))
      assert [reply] = json_response(conn, 200)

      assert %{
               "id" => _,
               "userId" => ^user_id,
               "username" => ^username,
               "avatar" => "http://localhost:4000/uploads" <> _,
               "createdAt" => _,
               "text" => "lol"
             } = reply
    end
  end

  describe "#create" do
    test "creates a reply", %{conn: conn, post: %{id: post_id}} do
      attrs = %{text: "lol"}
      conn = post(conn, Routes.post_reply_path(conn, :create, post_id), attrs)
      assert %{"text" => "lol"} = json_response(conn, 201)
    end
  end

  describe "#update" do
    test "updates a reply for a user", %{conn: conn, reply: %{id: id}} do
      attrs = %{"text" => "lel"}
      conn = patch(conn, Routes.reply_path(conn, :update, id), attrs)
      assert %{"text" => "lel"} = json_response(conn, 200)
    end

    test "cannot update a reply that does not belong to a current user", %{
      conn: conn,
      post: %{id: post_id}
    } do
      user = insert(:user)
      {:ok, reply} = Users.create_reply(user.id, post_id, %{"text" => "lil"})
      attrs = %{"text" => "lol"}
      conn = patch(conn, Routes.reply_path(conn, :update, reply.id), attrs)
      assert _ = json_response(conn, 401)
    end
  end

  defp base64_avatar do
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
  end
end
