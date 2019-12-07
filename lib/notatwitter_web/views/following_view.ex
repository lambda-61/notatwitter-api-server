defmodule NotatwitterWeb.FollowingView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("follows.json", %{follows: follows}) do
    render_many(follows, __MODULE__, "following.json")
  end

  def render("followers.json", %{followers: followers}) do
    render_many(followers, __MODULE__, "following.json")
  end

  def render("following.json", %{following: user}) do
    %{
      id: user.id,
      username: user.username,
      avatar: image_url({user.avatar, user}, :big)
    }
  end

  def render("followed.json", %{}) do
    %{}
  end

  def render("unfollowed.json", %{}) do
    %{}
  end
end
