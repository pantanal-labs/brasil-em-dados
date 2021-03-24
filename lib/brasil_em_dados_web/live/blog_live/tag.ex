defmodule BrasilEmDadosWeb.BlogLive.Tag do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @posts_per_page 10

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(current_page: 1, tag_name: params["tag_name"], update: "")
     |> get_posts(params["tag_name"])}
  end

  @impl true
  def handle_event("load-more", _params, socket) do
    {:noreply,
     socket
     |> update(:current_page, &(&1 + 1))
     |> update_with_append()
     |> get_posts(socket.assigns.tag_name)}
  end

  defp get_posts(socket, tag_name) do
    offset = (socket.assigns.current_page - 1) * @posts_per_page
    posts = Blog.list_posts_by_tag(tag_name, offset, @posts_per_page)

    assign(socket, posts: posts)
  end

  defp update_with_append(socket), do: assign(socket, update: "append")
end
