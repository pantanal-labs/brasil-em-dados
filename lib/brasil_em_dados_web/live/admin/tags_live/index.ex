defmodule BrasilEmDadosWeb.Admin.TagsLive.Index do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, tags: list_tags())}
  end

  @impl true
  def handle_event("delete", %{"tag-id" => tag_id}, socket) do
    tag = Blog.get_tag!(tag_id)
    Blog.delete_tag(tag)

    {:noreply, socket}
  end

  defp list_tags, do: Blog.list_tags()
end
