defmodule Notatwitter.User.Post.Reply do
  @moduledoc false

  use Ecto.Schema

  alias Notatwitter.User
  alias Notatwitter.User.Post

  schema "user_post_replies" do
    belongs_to :post, Post
    belongs_to :user, User

    field :text, :string

    timestamps()
  end
end
