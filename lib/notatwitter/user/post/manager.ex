defmodule Notatwitter.User.Post.Manager do
  @moduledoc false

  import Ecto.Query

  alias Ecto.Changeset
  alias Notatwitter.Repo
  alias Notatwitter.User.Post

  def list(user_id) do
    Post
    |> where([p], p.user_id == ^user_id)
    |> preload([:user])
    |> Repo.all()
  end

  def find(post_id) do
    Repo.find(Post, post_id)
  end

  def create(user_id, attrs) do
    with {:ok, post} <- do_create(user_id, attrs) do
      {:ok, Repo.preload(post, [:user])}
    end
  end

  defp do_create(user_id, attrs) do
    attrs = Map.put(attrs, "user_id", user_id)

    %Post{}
    |> Changeset.cast(attrs, [:text, :user_id])
    |> Changeset.foreign_key_constraint(:user_id)
    |> Changeset.validate_length(:text, max: 140, count: :bytes)
    |> Changeset.validate_required([:text, :user_id])
    |> Repo.insert()
  end

  def update(post_id, attrs) do
    with {:ok, post} <- find(post_id),
         {:ok, post} <- do_update(post, attrs) do
      {:ok, Repo.preload(post, [:user])}
    end
  end

  defp do_update(post, attrs) do
    post
    |> Changeset.cast(attrs, [:text])
    |> Changeset.validate_length(:text, max: 140, count: :bytes)
    |> Repo.update()
  end
end
