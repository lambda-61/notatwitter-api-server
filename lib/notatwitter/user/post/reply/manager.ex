defmodule Notatwitter.User.Post.Reply.Manager do
  @moduledoc false

  import Ecto.Query

  alias Ecto.Changeset
  alias Notatwitter.Repo
  alias Notatwitter.User.Post.Reply

  def list(post_id) do
    Reply
    |> where([r], r.post_id == ^post_id)
    |> preload([:user])
    |> Repo.all()
  end

  def find(reply_id) do
    Repo.find(Reply, reply_id)
  end

  def create(user_id, post_id, attrs) do
    with {:ok, reply} <- do_create(user_id, post_id, attrs) do
      {:ok, Repo.preload(reply, [:user])}
    end
  end

  defp do_create(user_id, post_id, attrs) do
    attrs = Map.merge(attrs, %{"user_id" => user_id, "post_id" => post_id})

    %Reply{}
    |> Changeset.cast(attrs, [:text, :post_id, :user_id])
    |> Changeset.foreign_key_constraint(:post_id)
    |> Changeset.foreign_key_constraint(:user_id)
    |> Changeset.validate_length(:text, max: 140, count: :bytes)
    |> Changeset.validate_required([:text, :user_id, :post_id])
    |> Repo.insert()
  end

  def update(%Reply{} = reply, attrs) do
    with {:ok, reply} <- do_update(reply, attrs) do
      {:ok, Repo.preload(reply, [:user])}
    end
  end

  defp do_update(reply, attrs) do
    reply
    |> Changeset.cast(attrs, [:text])
    |> Changeset.validate_length(:text, max: 140, count: :bytes)
    |> Repo.update()
  end
end
