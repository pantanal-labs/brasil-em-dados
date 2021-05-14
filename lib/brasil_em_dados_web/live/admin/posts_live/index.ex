defmodule BrasilEmDadosWeb.Admin.PostsLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [posts: []]}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    page = String.to_integer(params["page"] || "1")
    limit = String.to_integer(params["limit"] || "10")

    offset = (page - 1) * limit
    posts = Blog.list_posts(offset, limit)

    paginate_options = %{page: page, limit: limit}

    {:noreply, assign(socket, posts: posts, options: paginate_options)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Blog.get_post!(id)
    delete_post(post, socket)
  end

  defp pagination_link(socket, text, page, limit, class) do
    live_patch(text,
      to:
        Routes.posts_index_path(socket, :index,
          page: page,
          limit: limit
        ),
      class: class
    )
  end

  defp delete_post(post, socket) do
    case Blog.delete_post(post) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post deletado com sucesso!")
         |> redirect(to: Routes.posts_index_path(socket, :index))}

      {:error, _} ->
        {:noreply, socket |> put_flash(:error, "Error!!!")}
    end
  end
end
