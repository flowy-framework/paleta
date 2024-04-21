defmodule Paleta.Components.Sidebar do
  use Phoenix.LiveComponent

  @deprecated "Use dead component <.sidebar/> instead"
  def render(assigns) do
    ~H"""
    <div class="sidebar">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
