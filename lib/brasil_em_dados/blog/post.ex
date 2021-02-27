defmodule BrasilEmDados.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum
  alias BrasilEmDados.Accounts.User

  defenum(PostStatusEnum, published: 0, draft: 1, future: 2, private: 3)

  schema "posts" do
    field :body, :string
    field :title, :string
    field :slug, :string
    field :status, PostStatusEnum
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :body, :user_id, :status])
    |> validate_required([:title, :body, :slug, :user_id])
  end
end
