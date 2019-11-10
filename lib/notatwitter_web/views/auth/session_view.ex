defmodule NotatwitterWeb.Auth.SessionView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("show.json", %{user: %{username: name}, token: token}) do
    %{
      username: name,
      token: token
    }
  end

  def render("show.json", %{user: %{username: username}}) do
    %{username: username}
  end

  def render("show.json", _) do
    %{}
  end
end
