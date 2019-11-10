defmodule Notatwitter.Auth.Guardian.ErrorHandler do
  @moduledoc false

  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Jason.encode!(%{code: type, details: reason}))
  end
end
