defmodule Paleta.Utils.MarkdownHelper do
  def markdown_to_html(nil), do: ""

  def markdown_to_html(text) do
    parsed_content = Regex.replace(~r/:([a-z0-1\+]+):/, text, &emojify_short_name/2)
    {:ok, html_content, []} = Earmark.as_html(parsed_content, compact_output: true)

    html_content
  end

  defp emojify_short_name(match, short_name) do
    if emoji = Exmoji.from_short_name(short_name),
      do: Exmoji.EmojiChar.render(emoji),
      else: match
  end
end
