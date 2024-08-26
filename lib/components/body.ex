defmodule Paleta.Components.Body do
  use Paleta, :component

  slot(:inner_block, doc: "Body content", required: true)
  attr(:left_sidebar_open, :boolean, default: false)

  def body(assigns) do
    ~H"""
    <body
      x-data
      class={"is-header-blur" <> (@left_sidebar_open && " is-sidebar-open" || "")}
      x-bind="$store.global.documentBody"
    >
      <%= render_slot(@inner_block) %>
    </body>
    """
  end
end
