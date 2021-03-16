defmodule BrasilEmDados.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum
  alias BrasilEmDados.Accounts.User
  alias BrasilEmDados.Blog.{Tag, PostTag}

  defenum(PostStatusEnum, published: 0, draft: 1, future: 2, private: 3)

  schema "posts" do
    field :title, :string
    field :body, :string
    field :body_html, :string
    field :slug, :string
    field :status, PostStatusEnum
    belongs_to :user, User
    many_to_many :tags, Tag, join_through: PostTag

    timestamps()
  end

  @doc false
  def changeset(post, attrs, tags \\ []) do
    post
    |> cast(attrs, [:title, :slug, :body, :user_id, :status])
    |> validate_required([:title, :body, :slug, :user_id])
    |> put_assoc(:tags, tags)
    |> prepare_changes(&parse_markdown_to_html/1)
  end

  defp parse_markdown_to_html(changeset) do
    markdown_body = get_change(changeset, :body)
    {:ok, body_html, []} = Earmark.as_html(markdown_body)

    put_change(changeset, :body_html, body_html)
  end
end
