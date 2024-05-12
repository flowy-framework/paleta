defmodule Paleta.Components.Div do
  use Phoenix.Component

  attr(:tooltip, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def div(assigns) do
    ~H"""
    <div x-tooltip.light={@tooltip && "'#{@tooltip}'"} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
