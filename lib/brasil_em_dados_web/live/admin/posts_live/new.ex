defmodule BrasilEmDadosWeb.Admin.PostsLive.New do
  use BrasilEmDadosWeb, :live_view

  alias BrasilEmDados.Blog
  alias BrasilEmDados.Blog.Post
  alias BrasilEmDados.Utils.EditorjsConverter

  @impl true
  def mount(_params, _session, socket) do
    changeset = Blog.change_post(%Post{})

    {:ok, assign(socket, changeset: changeset, selected_tags: [])}
  end

  @impl true
  def handle_event("prepare-data", %{"post" => post}, socket) do
    {:noreply, socket |> assign(form_data: post) |> push_event("save-editor", %{})}
  end

  @impl true
  def handle_event("create-post", params, socket) do
    save_post(socket, params)
  end

  @impl true
  def handle_info({:set_tags, selected_tags}, socket) do
    {:noreply, assign(socket, selected_tags: selected_tags)}
  end

  defp save_post(%{assigns: assigns} = socket, %{"main_text" => main_text}) do
    {:ok, encoded_text} = Jason.encode(main_text)
    {:ok, parser} = EditorjsConverter.to_html(encoded_text)

    post = %{
      title: assigns.form_data["title"],
      slug: assigns.form_data["slug"],
      user_id: 1,
      body: parser
    }

    case Blog.create_post(post, assigns.selected_tags) do
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
