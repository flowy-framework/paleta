defmodule Paleta.Components.PageWrapper do
  use Paleta, :component

  slot(:inner_block, doc: "Page content", required: true)

  def page_wrapper(assigns) do
    ~H"""
    <div id="root" class="flex min-h-100vh grow bg-slate-50 dark:bg-navy-900" x-cloak>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
