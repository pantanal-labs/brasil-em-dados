defmodule BrasilEmDadosWeb.BlogLive.Show do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    post = Blog.get_post_by_slug(slug)

    {:ok, assign(socket, post: post, page_title: post.title)}
  end
end
