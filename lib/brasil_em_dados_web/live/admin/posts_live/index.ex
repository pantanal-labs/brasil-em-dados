defmodule BrasilEmDadosWeb.Admin.PostsLive.Index do
  use BrasilEmDadosWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, posts: [])}
  end
end
