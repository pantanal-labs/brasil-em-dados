defmodule BrasilEmDadosWeb.Admin.PostsLive.Edit do
  use BrasilEmDadosWeb, :live_view

  alias BrasilEmDados.Blog
  alias BrasilEmDados.Blog.Post

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)

    {:ok, assign(socket, post: post, changeset: changeset, selected_tags: post.tags)}
  end

  @impl true
  def handle_event("validate", %{"post" => post_params}, socket) do
    changeset =
      %Post{}
      |> Blog.change_post(post_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"post" => post_params}, socket) do
    save_post(socket, post_params)
  end

  @impl true
  def handle_info({:set_tags, selected_tags}, socket) do
    {:noreply, assign(socket, selected_tags: selected_tags)}
  end

  defp save_post(socket, post_params) do
    post_params = post_params
    |> Map.put("tags", socket.assigns.selected_tags)

    case Blog.update_post(socket.assigns.post, post_params) do
      {:ok, post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post criado")
         |> redirect(to: Routes.blog_show_path(socket, :show, post.slug))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
