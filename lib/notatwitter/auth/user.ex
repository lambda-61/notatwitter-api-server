defmodule Notatwitter.Auth.User do
  @moduledoc false

  use Ecto.Schema

  schema "users" do
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end
end
