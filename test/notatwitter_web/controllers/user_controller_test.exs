defmodule NotatwitterWeb.UserControllerTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase

  alias Notatwitter.Users

  setup %{conn: conn} do
    user = insert(:user, username: "asdf")
    {:ok, _} = Users.update_user(user.id, %{avatar: base64_avatar()})
    [conn: as_user(conn, user), user: user]
  end

  describe "#index" do
    test "displays users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert [_] = json_response(conn, 200)
    end
  end

  describe "#show" do
    test "displayes a user", %{conn: conn, user: %{id: user_id}} do
      conn = get(conn, Routes.user_path(conn, :show, user_id))
      assert result = json_response(conn, 200)

      assert %{
               "id" => ^user_id,
               "username" => "asdf",
               "avatar" => "http://localhost:4000/uploads/" <> _
             } = result
    end
  end

  describe "#update" do
    test "updates a username for current user", context do
      %{conn: conn, user: %{id: user_id}} = context
      attrs = %{username: "asdf2"}
      conn = patch(conn, Routes.user_path(conn, :update, user_id), attrs)
      assert result = json_response(conn, 200)
      assert %{"username" => "asdf2"} = result
    end

    test "updates an avatar for current user", context do
      %{conn: conn, user: %{id: user_id}} = context

      {:ok, profile} = Users.find_user(user_id)

      old_document =
        Notatwitter.User.Avatar.url({profile.avatar, profile}, :original)

      attrs = %{
        avatar:
          "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+K9XDwAD4gGu3HCNbQAAAABJRU5ErkJggg=="
      }

      conn = patch(conn, Routes.user_path(conn, :update, user_id), attrs)
      assert result = json_response(conn, 200)
      assert %{"avatar" => "http://localhost:4000" <> new_document} = result
      refute old_document == new_document
    end

    test "cannot update another user", %{conn: conn} do
      user = insert(:user)
      attrs = %{username: "kek"}
      conn = patch(conn, Routes.user_path(conn, :update, user.id), attrs)
      assert result = json_response(conn, 401)
    end
  end

  defp base64_avatar do
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
  end
end
