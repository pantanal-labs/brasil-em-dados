defmodule BrasilEmDadosWeb.BlogLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @posts_per_page 10

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(current_page: 1, update: "")
      |> get_posts()}
  end

  @impl true
  def handle_event("load-more", _params, socket) do
    {:noreply,
      socket
      |> update(:current_page, &(&1 + 1))
      |> update_with_append()
      |> get_posts()
    }
  end

  defp get_posts(socket) do
    offset = (socket.assigns.current_page - 1) * @posts_per_page
    posts = Blog.list_public_posts(offset, @posts_per_page)

    assign(socket, posts: posts)
  end

  defp update_with_append(socket), do: assign(socket, update: "append")
end
