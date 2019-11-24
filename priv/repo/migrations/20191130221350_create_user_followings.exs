defmodule Notatwitter.Repo.Migrations.CreateUserFollowings do
  use Ecto.Migration

  def change do
    create table(:user_followings) do
      add :follower_id, references(:users)
      add :target_id, references(:users)
      timestamps()
    end
  end
end
