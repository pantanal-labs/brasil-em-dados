defmodule BrasilEmDadosWeb.BlogLive.Show do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @some_html """
    <h1>Hello</h1>
    <p>Ola mundo</p>
  """

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    post = Blog.get_post_by_slug(slug)

    {:ok, assign(socket, post: post, slug: slug, html: @some_html)}
  end
end
