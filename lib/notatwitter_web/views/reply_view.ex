defmodule NotatwitterWeb.ReplyView do
  @moduledoc false

  use NotatwitterWeb, :view

  def render("index.json", %{replies: replies}) do
    render_many(replies, __MODULE__, "reply.json")
  end

  def render("created.json", %{reply: reply}) do
    render_one(reply, __MODULE__, "reply.json")
  end

  def render("updated.json", %{reply: reply}) do
    render_one(reply, __MODULE__, "reply.json")
  end

  def render("reply.json", %{reply: reply}) do
    user = reply.user

    %{
      id: reply.id,
      user_id: user.id,
      username: user.username,
      avatar: image_url({user.avatar, user}, :big),
      created_at: datetime_to_integer(reply.inserted_at),
      text: reply.text
    }
  end
end
