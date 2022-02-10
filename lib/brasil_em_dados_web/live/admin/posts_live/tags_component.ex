defmodule BrasilEmDadosWeb.Admin.PostsLive.TagsComponent do
  use BrasilEmDadosWeb, :live_component

  alias BrasilEmDados.Blog

  @impl true
  def mount(socket) do
    {:ok,
     assign(socket,
       search_results: [],
       search_phrase: "",
       tags: list_tags(),
       selected_tags: []
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="mb-4 text-lg font-semibold text-gray-600 dark:text-gray-300">Tags</div>
      <div class="py-2 px-3 mb-4 bg-white border-b border-gray-300" phx-target={@myself}>
        <%= for tag <- @tags do %>
          <span class={"inline-block text-base #{if selected?(@selected_tags, tag), do: "bg-red-400", else: "bg-green-400"} text-white py-1 px-2 mr-1 mb-1 rounded"}>
            <span class="text-base font-semibold text-black"><%= tag.name %></span>
            <%= if selected?(@selected_tags, tag) do %>
              <a href="#" class="text-black text-lg hover:text-white" phx-target={@myself} phx-click="delete" phx-value-tag-id={tag.id}>&times</a>
            <% else %>
              <a href="#" class="text-black text-lg hover:text-white" phx-target={@myself} phx-click="pick" phx-value-tag-id={tag.id} >+</a>
            <% end %>
          </span>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("pick", %{"tag-id" => tag_id}, %{assigns: assigns} = socket) do
    tag = Blog.get_tag!(tag_id)

    if Enum.member?(assigns.selected_tags, tag) do
      {:noreply, socket}
    else
      selected_tags = [tag | socket.assigns.selected_tags]
      send(self(), {:set_tags, selected_tags})

      {:noreply, assign(socket, selected_tags: selected_tags)}
    end
  end

  @impl true
  def handle_event("delete", %{"tag-id" => tag_id}, socket) do
    tag = Blog.get_tag!(tag_id)
    selected_tags = List.delete(socket.assigns.selected_tags, tag)
    send(self(), {:set_tags, selected_tags})

    {:noreply, assign(socket, selected_tags: selected_tags)}
  end

  def selected?(selected_tags, tag), do: Enum.member?(selected_tags, tag)

  defp list_tags() do
    Blog.list_tags()
  end
end
