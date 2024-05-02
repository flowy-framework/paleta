defmodule Paleta.Components.CardWithSideMenu do
  use Phoenix.Component
  import Paleta.Components.Card

  defmodule Item do
    defstruct [:key, :title, :icon, :path]

    def build(key, title, icon, path) do
      %__MODULE__{key: key, title: title, icon: icon, path: path}
    end
  end

  attr(:items, :list, required: true)
  attr(:active, :atom, required: true)
  slot(:inner_block)

  def card_with_side_menu(assigns) do
    ~H"""
    <div class="grid grid-cols-12 gap-4 sm:gap-5 lg:gap-6">
      <div class="col-span-12 lg:col-span-2">
        <div class="p-4 card sm:p-5">
          <ul class="mt-6 space-y-1.5 font-inter font-medium">
            <li :for={item <- @items}>
              <.link class={class(@active == item.key)} href={item.path}>
                <i class={item.icon}></i>
                <span><%= item.title %></span>
              </.link>
            </li>
          </ul>
        </div>
      </div>
      <div class="col-span-12 lg:col-span-10">
        <.card>
          <%= render_slot(@inner_block) %>
        </.card>
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
