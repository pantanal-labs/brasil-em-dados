defmodule BrasilEmDadosWeb.BlogLive.Show do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDadosWeb.BlogLiveView
  alias BrasilEmDados.Blog

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    post = Blog.get_post_by_slug(slug)

    {:ok, assign(socket, post: post, slug: slug)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(BlogLiveView, "show.html", assigns)
  end
end
