defmodule Paleta.Components.AppHeaderWrapper do
  use Paleta, :component

  slot(:inner_block, doc: "Page content", required: true)
  attr(:class, :string, default: "header print:hidden")

  def app_header_wrapper(assigns) do
    ~H"""
    <nav class={@class} @click.away="$store.global.isSidebarExpanded = false">
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end
end
