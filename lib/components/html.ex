defmodule Paleta.Components.Html do
  use Paleta, :component

  slot(:inner_block, required: true)

  def html(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en">
      <%= render_slot(@inner_block) %>
    </html>
    """
  end
end
