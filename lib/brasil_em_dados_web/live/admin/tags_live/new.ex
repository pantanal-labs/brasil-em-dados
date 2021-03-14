defmodule BrasilEmDadosWeb.Admin.TagsLive.New do
  use BrasilEmDadosWeb, :live_view
  alias BrasilEmDados.Blog
  alias BrasilEmDados.Blog.Tag

  @impl true
  def mount(_params, _session, socket) do
    changeset = Blog.change_tag(%Tag{})

    {:ok, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("validate", %{"tag" => tag_params}, socket) do
    changeset =
      %Tag{}
      |> Blog.change_tag(tag_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"tag" => tag_params}, socket) do
    save_tag(socket, tag_params)
  end

  defp save_tag(socket, tag_params) do
    case Blog.create_tag(tag_params) do
      {:ok, _tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tat created successfully")
         |> push_redirect(to: Routes.tags_index_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
