defmodule Notatwitter.User.Following.Manager do
  @moduledoc false

  import Ecto.Query

  alias Ecto.Changeset
  alias Notatwitter.Repo
  alias Notatwitter.User
  alias Notatwitter.User.Following

  def list_follows(user_id) do
    list_following(user_id, :follows)
  end

  def list_followers(user_id) do
    list_following(user_id, :followers)
  end

  defp list_following(user_id, assoc) do
    maybe_user =
      User
      |> preload([^assoc])
      |> Repo.find(user_id)

    with {:ok, %{^assoc => users}} <- maybe_user do
      {:ok, users}
    end
  end

  def follow(current_user_id, target_user_id) do
    attrs = %{follower_id: current_user_id, target_id: target_user_id}

    %Following{}
    |> Changeset.cast(attrs, [:follower_id, :target_id])
    |> Changeset.validate_required([:follower_id, :target_id])
    |> Changeset.foreign_key_constraint(:follwer_id)
    |> Changeset.foreign_key_constraint(:target_id)
    |> Repo.insert(on_conflict: :nothing)
  end

  def unfollow(current_user_id, target_user_id) do
    Following
    |> where([f], f.follower_id == ^current_user_id)
    |> where([f], f.target_id == ^target_user_id)
    |> Repo.delete_all([])
  end
end
