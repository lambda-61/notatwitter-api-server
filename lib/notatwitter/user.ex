defmodule Notatwitter.User do
  @moduledoc false

  use Ecto.Schema

  alias Notatwitter.User.{Avatar, Following, Post}

  schema "users" do
    many_to_many :followers, __MODULE__,
      join_through: Following,
      join_keys: [target_id: :id, follower_id: :id]

    many_to_many :follows, __MODULE__,
      join_through: Following,
      join_keys: [follower_id: :id, target_id: :id]

    has_many :posts, Post

    field :username, :string
    field :avatar, Avatar.Type

    timestamps()
  end
end
