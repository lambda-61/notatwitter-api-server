defmodule NotatwitterWeb.PageController do
  use NotatwitterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
