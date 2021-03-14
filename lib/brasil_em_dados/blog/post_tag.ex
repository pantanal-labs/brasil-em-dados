defmodule BrasilEmDados.Blog.PostTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BrasilEmDados.Blog.{Post, Tag}

  schema "posts_tags" do
    belongs_to :post, Post
    belongs_to :tag, Tag

    timestamps()
  end

  def changeset(post_tag, attrs) do
    post_tag
    |> cast(attrs, [])
    |> unique_constraint(:name, name: :posts_tags_post_id_tag_id_index)
    |> cast_assoc(:tag)
  end
end
