defmodule NotatwitterWeb.ErrorController do
  @moduledoc false

  use NotatwitterWeb, :controller

  alias NotatwitterWeb.ErrorView

  def call(conn, {:error, :invalid_credentials}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("401.json", %{error: "invalid_credentials"})
  end
end
