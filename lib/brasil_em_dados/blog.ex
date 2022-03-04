defmodule BrasilEmDados.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias BrasilEmDados.Repo

  alias BrasilEmDados.Blog.{Post, Tag}

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(offset, limit) do
    Post
    |> offset(^offset)
    |> limit(^limit)
    |> preload([:user, :tags])
    |> Repo.all()
  end

  def list_public_posts(page) do
    Post
    |> where(status: "published")
    |> order_by([p], asc: p.inserted_at, asc: p.id)
    |> preload([:user, :tags])
    |> Repo.paginate(page: page)
  end

  def list_posts_by_tag(tag_name, page) do
    query = from p in Post,
        join: t in assoc(p, :tags),
        where: t.name == ^tag_name,
        preload: [:tags]

    Repo.paginate(query, page: page)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Repo.get!(Post, id) |> Repo.preload(:tags)
  end

  def get_post_by_slug(slug) do
    Repo.get_by(Post, slug: slug) |> Repo.preload([:tags])
  end

  def get_total_posts(), do: Repo.all(Post) |> Enum.count()

  @doc """
  Get a single Tag
  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  def get_tag_by_name!(tag_name), do: Repo.get_by!(Tag, name: tag_name)

  @doc """
  Returns a list of tags
  """
  def list_tags(), do: Repo.all(Tag)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end
end
