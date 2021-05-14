defmodule BrasilEmDados.Blog.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BrasilEmDados.Blog.{Post, PostTag}

  schema "tags" do
    field :name, :string
    field :color, :string
    many_to_many :posts, Post, join_through: PostTag

    timestamps()
  end

  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
  end
end
