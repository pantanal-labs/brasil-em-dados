defmodule BrasilEmDadosWeb.BlogLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDadosWeb.BlogLiveView
  alias BrasilEmDados.Blog

  def mount(_params, _session, socket) do
    {:ok, assign(socket, posts: get_posts())}
  end

  def render(assigns) do
    Phoenix.View.render(BlogLiveView, "index.html", assigns)
  end

  defp get_posts() do
    Blog.list_posts()
  end
end
