defmodule BrasilEmDadosWeb.BlogLive.Tag do
  use BrasilEmDadosWeb, :live_view
	alias BrasilEmDados.Blog

	@impl true
	def mount(params, _session, %{assigns: assigns} = socket) do
    page = String.to_integer(params["page"] || "1")
		{:ok, socket 
			|> assign(page: page)
			|> get_tag(params["tag_name"])
			|> get_posts(params["tag_name"])}
	end
	
	defp get_posts(socket, tag_name) do
    page = socket.assigns.page
    %{entries: posts, total_pages: total_pages} = Blog.list_posts_by_tag(tag_name, page)

    assign(socket, posts: posts, total_pages: total_pages)
  end
	
  defp get_tag(socket, tag_name) do
    assign(socket, tag: Blog.get_tag_by_name!(tag_name))
  end
end
