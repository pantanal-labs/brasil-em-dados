defmodule BrasilEmDadosWeb.Admin.PostsLive.New do
  use BrasilEmDadosWeb, :live_view

  alias BrasilEmDados.Blog
  alias BrasilEmDados.Blog.Post

  @impl true
  def mount(_params, _session, socket) do
    changeset = Blog.change_post(%Post{})

    {:ok, assign(socket, changeset: changeset, selected_tags: [])}
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
    post_params =
      post_params
      |> Map.put("user_id", 1)
      |> Map.put("tags", socket.assigns.selected_tags)

    case Blog.create_post(post_params) do
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
