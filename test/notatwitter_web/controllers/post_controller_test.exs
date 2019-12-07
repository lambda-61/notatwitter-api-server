defmodule NotatwitterWeb.PostControllerTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase

  alias Notatwitter.Users

  setup %{conn: conn} do
    user = insert(:user, username: "asdf")
    {:ok, profile} = Users.find_user(user.id)
    {:ok, _} = Users.update_user(profile, %{avatar: base64_avatar()})
    post = insert(:post, user_id: user.id, text: "kek")
    [conn: as_user(conn, user), user: user, post: post]
  end

  describe "#index" do
    test "shows all the posts from a user", context do
      %{
        conn: conn,
        user: %{id: user_id, username: username},
        post: %{id: post_id}
      } = context

      conn = get(conn, Routes.user_post_path(conn, :index, user_id))
      assert [post] = json_response(conn, 200)

      assert %{
               "id" => ^post_id,
               "userId" => ^user_id,
               "username" => ^username,
               "avatar" => "http://localhost:4000/uploads/" <> _,
               "createdAt" => _,
               "text" => "kek"
             } = post
    end
  end

  describe "#create" do
    test "creates a post for user", %{conn: conn} do
      attrs = %{text: "lol"}
      conn = post(conn, Routes.post_path(conn, :create), attrs)
      assert %{"text" => "lol"} = json_response(conn, 201)
    end
  end

  describe "#update" do
    test "updates a post for a user", %{conn: conn, post: %{id: id}} do
      attrs = %{text: "lol"}
      conn = patch(conn, Routes.post_path(conn, :update, id), attrs)
      assert %{"text" => "lol"} = json_response(conn, 200)
    end

    test "cannot update a post that does not belong to a current user",
         context do
      %{conn: conn} = context
      user = insert(:user)
      post = insert(:post, user_id: user.id)
      attrs = %{text: "lol"}
      conn = patch(conn, Routes.post_path(conn, :update, post.id), attrs)
      assert _ = json_response(conn, 401)
    end
  end

  defp base64_avatar do
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
  end
end
