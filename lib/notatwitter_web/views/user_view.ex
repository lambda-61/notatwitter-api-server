defmodule NotatwitterWeb.UserView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("index.json", %{users: users}) do
    render_many(users, __MODULE__, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("registred.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("updated.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      avatar: image_url({user.avatar, user}, :original)
    }
  end
end
