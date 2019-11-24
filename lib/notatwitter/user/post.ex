defmodule Notatwitter.User.Post do
  @moduledoc false

  use Ecto.Schema

  alias Notatwitter.User

  schema "user_posts" do
    belongs_to :user, User

    field :text, :string

    timestamps()
  end
end
