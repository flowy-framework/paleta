defmodule Paleta.Components.CardWithSideMenu do
  use Paleta, :component

  defmodule Item do
    defstruct [:key, :label, :title, :icon, :path, :order]

    def build(map) when is_map(map) do
      struct(__MODULE__, map)
    end

    def build(key, title, icon, path) do
      %__MODULE__{key: key, label: title, title: title, icon: icon, path: path}
    end

    def build(key, label, title, icon, path) do
      %__MODULE__{key: key, label: label, title: title, icon: icon, path: path}
    end
  end

  attr(:items, :list, required: true)
  attr(:active, :atom, required: true)
  attr(:class, :string, default: "grid grid-cols-12 gap-4 sm:gap-5 lg:gap-6")
  slot(:inner_block)

  def card_with_side_menu(assigns) do
    ~H"""
    <div class={@class}>
      <div class="col-span-12 lg:col-span-2">
        <div class="p-4 card sm:p-5">
          <ul class="mt-2 space-y-1.5 font-inter font-medium">
            <li :for={item <- @items}>
              <.link class={class(@active == item.key)} href={item.path}>
                <i class={item.icon}></i>
                <span><%= item.label %></span>
              </.link>
            </li>
          </ul>
        </div>
      </div>
      <div class="col-span-12 lg:col-span-10">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp class(true),
    do:
      "flex items-center space-x-2 rounded-lg bg-primary px-4 py-2.5 tracking-wide text-white outline-none transition-all dark:bg-accent"

  defp class(false),
    do:
      "group flex space-x-2 rounded-lg px-4 py-2.5 tracking-wide outline-none transition-all hover:bg-slate-100 hover:text-slate-800 focus:bg-slate-100 focus:text-slate-800 dark:hover:bg-navy-600 dark:hover:text-navy-100 dark:focus:bg-navy-600 dark:focus:text-navy-100"
end
