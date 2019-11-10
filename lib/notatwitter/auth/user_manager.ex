defmodule Notatwitter.Auth.UserManager do
  @moduledoc false

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
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
