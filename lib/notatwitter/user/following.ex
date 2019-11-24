defmodule Notatwitter.User.Following do
  @moduledoc false

  use Ecto.Schema

  alias Notatwitter.User

  schema "user_followings" do
    belongs_to :follower, User
    belongs_to :target, User

    timestamps()
  end
end
