defmodule Paleta.Components.MainContentWrapper do
  use Paleta, :component

  slot(:inner_block, doc: "Page content", required: true)

  def main_content_wrapper(assigns) do
    ~H"""
    <%= render_slot(@inner_block) %>
    """
  end
end
