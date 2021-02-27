defmodule BrasilEmDadosWeb.BlogLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  def mount(_params, _session, socket) do
    {:ok, assign(socket, posts: get_posts())}
  end

  defp get_posts() do
    Blog.list_public_posts(0, 10)
  end
end
