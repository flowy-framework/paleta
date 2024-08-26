defmodule Paleta.Components.Tabs do
  @moduledoc """
  ## Example:
    <.tabs default="overview" id="product" class="w-[400px]">
      <:header target="overview" label="Overview" />
      <:header target="images" label="Images" />
      <:tab id="overview">
        <.card>
          Product
        </.card>
      </:tab>
      <:tab id="images">
        <.card>
          Images
        </.card>
      </:tab>
    </.tabs>
  """
  use Paleta, :component

  attr(:id, :string, required: true, doc: "id for root tabs tag")
  attr(:default, :string, default: nil, doc: "default tab value")
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:header, required: true) do
    attr(:target, :string)
    attr(:label, :string)
  end

  slot(:tab, required: true) do
    attr(:id, :string)
  end

  def tabs(assigns) do
    ~H"""
    <div class="flex flex-col tabs" id={@id} {@rest} phx-mounted={show_tab(@id, @default)}>
      <div class="overflow-x-auto rounded-lg is-scrollbar-hidden bg-slate-200 text-slate-600 dark:bg-navy-800 dark:text-navy-200">
        <div class="tabs-list flex px-1.5 py-1">
          <button
            :for={header <- @header}
            class="tabs-trigger btn shrink-0 px-3 py-1.5 font-medium data-[state=active]:bg-white data-[state=active]:shadow data-[state=active]:dark:bg-navy-500 data-[state=active]:dark:text-navy-100"
            data-target={header[:target]}
            phx-click={show_tab(@id, header[:target])}
          >
            <%= header[:label] %>
          </button>
        </div>
      </div>

      <div :for={tab <- @tab} class="pt-4 tabs-content tab-content" value={tab[:id]}>
        <%= render_slot(tab) %>
      </div>
    </div>
    """
  end

  # Set selected tab to active
  # show appropriate tab content
  defp show_tab(root, value) do
    %JS{}
    |> JS.set_attribute({"data-state", ""}, to: "##{root} .tabs-trigger[data-state=active]")
    |> JS.set_attribute({"data-state", "active"},
      to: "##{root} .tabs-trigger[data-target=#{value}]"
    )
    |> JS.hide(to: "##{root} .tabs-content:not([value=#{value}])")
    |> JS.show(to: "##{root} .tabs-content[value=#{value}]")
  end
end
