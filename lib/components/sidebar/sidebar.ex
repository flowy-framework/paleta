defmodule Paleta.Components.Sidebar do
  use Phoenix.LiveComponent

  @deprecated "Use dead component <.sidebar/> instead"
  def render(assigns) do
    assigns = assign(assigns, :class, "sidebar")

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
