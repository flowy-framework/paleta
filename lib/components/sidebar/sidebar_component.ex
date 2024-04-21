defmodule Paleta.Components.SidebarComponent do
  use Phoenix.Component

  slot(:inner_block, required: true)

  def sidebar(assigns) do
    ~H"""
    <div class="sidebar">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
