defmodule BrasilEmDados.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias BrasilEmDados.Accounts.User

  schema "posts" do
    field :body, :string
    field :title, :string
    field :slug, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :body, :user_id])
    |> validate_required([:title, :body, :slug, :user_id])
  end
end
