defmodule NotatwitterWeb.Auth.SessionView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("show.json", %{user: %{id: id, username: name}, token: token}) do
    %{
      id: id,
      username: name,
      token: token
    }
  end

  def render("show.json", %{user: %{id: id, username: username}}) do
    %{id: id, username: username}
  end

  def render("show.json", _) do
    %{}
  end
end
