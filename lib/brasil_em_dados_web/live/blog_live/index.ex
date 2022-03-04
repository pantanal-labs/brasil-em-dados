defmodule BrasilEmDadosWeb.BlogLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @impl true
  def mount(params, _session, %{assigns: assigns} = socket) do
    page = String.to_integer(params["page"] || "1")

    {:ok,
     socket
     |> assign(:page, page)
     |> get_posts()}
  end

  defp get_posts(socket) do
    page = socket.assigns.page
    %{entries: posts, total_pages: total_pages} = Blog.list_public_posts(page)
    assign(socket, posts: posts, total_pages: total_pages)
  end
end
