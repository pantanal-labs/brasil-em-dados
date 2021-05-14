defmodule BrasilEmDadosWeb.Admin.DashboardLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, total_posts: Blog.get_total_posts())}
  end
end
