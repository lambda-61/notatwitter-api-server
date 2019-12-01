defmodule NotatwitterWeb.Auth.SessionControllerTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase

  alias Notatwitter.Auth.UserManager

  setup %{conn: conn} do
    {:ok, user} = UserManager.create(%{username: "asdf", password: "asdfasdf"})
    [conn: as_user(conn, user), user: user, orig_conn: conn]
  end

  describe "#login" do
    test "logs in on valid credentials", context do
      %{orig_conn: conn, user: %{id: user_id}} = context
      attrs = %{username: "asdf", password: "asdfasdf"}
      conn = post(conn, Routes.session_path(conn, :login), attrs)
      assert result = json_response(conn, 200)

      assert %{
               "id" => ^user_id,
               "username" => "asdf",
               "token" => _
             } = result
    end

    test "does not log in on invalid credentials", %{orig_conn: conn} do
      attrs = %{username: "asdf", password: "keklol"}
      conn = post(conn, Routes.session_path(conn, :login), attrs)
      assert _ = json_response(conn, 401)
    end

    test "puts cookies after successful login", %{orig_conn: conn} do
      attrs = %{username: "asdf", password: "asdfasdf"}

      %{resp_headers: headers} =
        post(conn, Routes.session_path(conn, :login), attrs)

      assert {"set-cookie", "sessionToken" <> _} =
               Enum.find(headers, &(elem(&1, 0) == "set-cookie"))
    end
  end

  describe "#session" do
    test "returns session for current user", context do
      %{conn: conn, user: %{id: user_id}} = context
      conn = get(conn, Routes.session_path(conn, :session))
      assert result = json_response(conn, 200)
      assert %{"id" => ^user_id, "username" => "asdf"} = result
    end

    test "returns 401 if not logged in", %{orig_conn: conn} do
      conn = get(conn, Routes.session_path(conn, :session))
      assert _ = json_response(conn, 401)
    end
  end
end
