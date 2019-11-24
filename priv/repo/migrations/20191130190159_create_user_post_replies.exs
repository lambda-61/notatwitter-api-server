defmodule Notatwitter.Repo.Migrations.CreateUserPostReplies do
  use Ecto.Migration

  def change do
    create table(:user_post_replies) do
      add :post_id, references(:user_posts)
      add :user_id, references(:users)
      add :text, :string
      timestamps()
    end
  end
end
