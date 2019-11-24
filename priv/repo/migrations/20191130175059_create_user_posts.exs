defmodule Notatwitter.Repo.Migrations.CreateUserPosts do
  use Ecto.Migration

  def change do
    create table(:user_posts) do
      add :user_id, references(:users)
      add :text, :string
      timestamps()
    end
  end
end
