defmodule NotatwitterWeb.PostView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("index.json", %{posts: posts}) do
    render_many(posts, __MODULE__, "post.json")
  end

  def render("created.json", %{post: post}) do
    render_one(post, __MODULE__, "post.json")
  end

  def render("updated.json", %{post: post}) do
    render_one(post, __MODULE__, "post.json")
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      user_id: post.user.id,
      username: post.user.username,
      avatar: image_url({post.user.avatar, post.user}, :original),
      created_at: datetime_to_integer(post.inserted_at),
      text: post.text
    }
  end
end
