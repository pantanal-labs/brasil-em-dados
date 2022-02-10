defmodule BrasilEmDados.Repo.Migrations.AddStatusToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      # 0 = published
      add :status, :integer, default: 0
    end

    create index(:posts, [:status])
  end
end
