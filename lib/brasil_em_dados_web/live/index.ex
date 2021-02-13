defmodule BrasilEmDadosWeb.BlogLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDadosWeb.BlogLiveView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(BlogLiveView, "index.html", assigns)
  end
end
