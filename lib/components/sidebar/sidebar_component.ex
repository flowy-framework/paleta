defmodule Paleta.Components.SidebarComponent do
  use Phoenix.Component

  slot(:inner_block, required: true)
  attr(:class, :string, default: "sidebar")

  def sidebar(assigns) do
    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
