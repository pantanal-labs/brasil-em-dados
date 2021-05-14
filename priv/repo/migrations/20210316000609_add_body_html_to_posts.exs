defmodule BrasilEmDados.Repo.Migrations.AddBodyHtmlToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :body_html, :text, null: false
    end
  end
end
