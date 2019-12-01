defmodule Notatwitter.User.Manager do
  @moduledoc false

  alias Ecto.Changeset
  alias Notatwitter.{Repo, User}

  def list do
    Repo.all(User)
  end

  def find(id) do
    Repo.find(User, id)
  end

  def update(%User{} = user, attrs) do
    user
    |> Changeset.cast(attrs, [:username])
    |> Arc.Ecto.Schema.cast_attachments([:avatar])
    |> Changeset.validate_required([:username])
    |> Repo.update()
  end
end
