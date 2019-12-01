defmodule Notatwitter.User.AccessPolicy do
  @moduledoc false

  @behaviour Bodyguard.Policy

  @impl true
  def authorize(:update_user, %{id: id}, %{id: id}) do
    :ok
  end

  @impl true
  def authorize(:create_post, %{id: id}, %{id: id}) do
    :ok
  end

  @impl true
  def authorize(:update_post, %{id: id}, %{user_id: id}) do
    :ok
  end

  @impl true
  def authorize(:update_reply, %{id: id}, %{user_id: id}) do
    :ok
  end

  @impl true
  def authorize(_, _, _) do
    :error
  end
end
