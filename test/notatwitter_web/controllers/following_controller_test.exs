defmodule NotatwitterWeb.FollowingControllerTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase

  alias Notatwitter.Users

  setup %{conn: conn} do
    user1 = insert(:user, username: "user1")
    user2 = insert(:user, username: "user2")
    [conn: as_user(conn, user1), user1: user1, user2: user2]
  end

  describe "#follows" do
    setup %{user1: %{id: user1_id}, user2: %{id: user2_id}} do
      {:ok, _} = Users.follow(user2_id, user1_id)
      :ok
    end

    test "shows follows of a user", context do
      %{conn: conn, user2: %{id: user2_id}} = context
      conn = get(conn, Routes.user_following_path(conn, :follows, user2_id))
      assert [user1] = json_response(conn, 200)
      assert %{"username" => "user1"} = user1
    end
  end

  describe "#followers" do
    setup %{user1: %{id: user1_id}, user2: %{id: user2_id}} do
      {:ok, _} = Users.follow(user1_id, user2_id)
      :ok
    end

    test "shows followers of a user", context do
      %{conn: conn, user2: %{id: user2_id}} = context
      conn = get(conn, Routes.user_following_path(conn, :followers, user2_id))
      assert [user1] = json_response(conn, 200)
      assert %{"username" => "user1"} = user1
    end
  end

  describe "#follow" do
    test "responds", %{conn: conn, user2: %{id: user2_id}} do
      conn = post(conn, Routes.user_following_path(conn, :follow, user2_id))
      assert _ = json_response(conn, 200)
    end
  end

  describe "#unfollow" do
    test "responds", %{conn: conn, user2: %{id: user2_id}} do
      conn = delete(conn, Routes.user_following_path(conn, :unfollow, user2_id))
      assert _ = json_response(conn, 204)
    end
  end
end
