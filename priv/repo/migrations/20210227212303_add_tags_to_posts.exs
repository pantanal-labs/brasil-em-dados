defmodule BrasilEmDados.Repo.Migrations.AddTagsToPosts do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string, null: :false
      add :color, :string, null: :false

      timestamps()
    end

    create unique_index(:tags, [:name])

    create table(:posts_tags) do
      add :tag_id, references(:tags, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:posts_tags, [:post_id, :tag_id])
  end
end
