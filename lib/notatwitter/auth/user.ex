defmodule Notatwitter.Auth.User do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @fields ~w(username password)a

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> put_password_hash
  end

  defp put_password_hash(%Ecto.Changeset{} = changeset) do
    case get_field(changeset, :password) do
      nil -> changeset
      password -> change(changeset, password_hash: Argon2.hash_pwd_salt(password))
    end
  end
end
