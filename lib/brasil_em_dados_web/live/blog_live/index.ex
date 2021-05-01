defmodule BrasilEmDadosWeb.BlogLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @posts_per_page 10

  @impl true
  def mount(params, _session, %{assigns: assigns} = socket) do
    if assigns.live_action == :index do
      {:ok,
        socket
        |> assign(current_page: 1, update: "")
        |> get_posts(:index)}
    else
      {:ok,
        socket
        |> assign(current_page: 1, update: "")
        |> get_tag(params["tag_name"])
        |> get_posts(:tag, params["tag_name"])}
    end
  end

  @impl true
  def handle_event("load-more", _params, %{assigns: assigns} = socket) do
    {:noreply,
      socket
      |> update(:current_page, &(&1 + 1))
      |> update_with_append()
      |> get_posts(assigns.live_action)
    }
  end

  defp get_posts(socket, :index) do
    offset = (socket.assigns.current_page - 1) * @posts_per_page
    posts = Blog.list_public_posts(offset, @posts_per_page)

    assign(socket, posts: posts)
  end

  defp get_posts(socket, :tag, tag_name) do
    offset = (socket.assigns.current_page - 1) * @posts_per_page
    posts = Blog.list_posts_by_tag(tag_name, offset, @posts_per_page)

    assign(socket, posts: posts)
  end

  defp update_with_append(socket), do: assign(socket, update: "append")

  defp get_tag(socket, tag_name) do
    assign(socket, tag: Blog.get_tag_by_name!(tag_name))
  end
end
