defmodule NotatwitterWeb.Auth.RegistrationControllerTest do
  @moduledoc false

  use NotatwitterWeb.ConnCase

  describe "#register" do
    test "registers a user", %{conn: conn} do
      attrs = %{username: "username", password: "password"}
      conn = post(conn, Routes.registration_path(conn, :register), attrs)
      assert result = json_response(conn, 201)
      assert %{"id" => _, "username" => "username"} = result
    end

    test "does not register a user with taken username", %{conn: conn} do
      insert(:user, username: "kek")
      attrs = %{username: "kek", password: "kekekekek"}
      conn = post(conn, Routes.registration_path(conn, :register), attrs)
      assert result = json_response(conn, 422)

      assert %{
               "errors" => [
                 %{"code" => "taken", "details" => "username"}
               ]
             } = result
    end
  end
end
