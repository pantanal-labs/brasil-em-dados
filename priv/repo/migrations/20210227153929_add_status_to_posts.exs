defmodule BrasilEmDados.Repo.Migrations.AddStatusToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :status, :integer, default: 0 # 0 = published
    end

    create index(:posts, [:status])
  end
end
