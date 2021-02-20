defmodule BrasilEmDadosWeb.AdminLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.AdminView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(AdminView, "index.html", assigns)
  end
end
