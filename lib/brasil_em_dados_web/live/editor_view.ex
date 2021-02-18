defmodule BrasilEmDadosWeb.EditorLive do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDadosWeb.EditorLiveView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(EditorLiveView, "index.html", assigns)
  end
end
