defmodule Notatwitter.Auth.UserManager do
  @moduledoc false

  alias Ecto.Changeset
  alias Notatwitter.Auth.User
  alias Notatwitter.Repo

  def find(id) do
    Repo.find(User, id)
  end

  def find_by(opts) do
    Repo.find_by(User, opts)
  end

  def create(attrs) do
    %User{}
    |> Changeset.cast(attrs, [:username, :password])
    |> Changeset.validate_required([:username, :password])
    |> Changeset.unique_constraint(:username, message: "taken")
    |> put_password_hash
    |> Repo.insert()
  end

  defp put_password_hash(%Changeset{} = changeset) do
    case Changeset.get_field(changeset, :password) do
      nil ->
        changeset

      password ->
        hash = Argon2.hash_pwd_salt(password)
        Changeset.change(changeset, password_hash: hash)
    end
  end
end
