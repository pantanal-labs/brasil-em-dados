defmodule BrasilEmDados.Utils.EditorjsConverter do
  def to_html(editorjs_output) do
    {:ok, to_json} = Jason.decode(editorjs_output)

    content =
      Enum.reduce(to_json, "", fn block, acc ->
        parsed_block = parse_block(block)
        acc <> parsed_block
      end)

    {:ok, content}
  end

  defp parse_block(%{"type" => "paragraph", "data" => %{"text" => text}}) do
    "<p>#{text}</p>"
  end

  defp parse_block(%{"type" => "header", "data" => data}) do
    %{"text" => text, "level" => level} = data
    "<h#{level} class=\"text-2xl font-bold mt-6 mb-4\">#{text}<h#{level}/>"
  end

  defp parse_block(_) do
    ""
  end
end
