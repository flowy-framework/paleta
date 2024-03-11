defmodule Paleta.Components.Sidebar.MainItem do
==> timex
Compiling 62 files (.ex)
Compiling lib/l10n/gettext.ex (it's taking more than 10s)
==> castore
Compiling 1 file (.ex)
Generated castore app
==> tailwind
Compiling 3 files (.ex)
Generated tailwind app
==> esbuild
Compiling 4 files (.ex)
Generated esbuild app
==> earmark
Compiling 3 files (.erl)
Compiling 61 files (.ex)
Generated earmark app
==> websock
Compiling 1 file (.ex)
Generated websock app
==> websock_adapter
Compiling 4 files (.ex)
Generated websock_adapter app
==> phoenix
Compiling 71 files (.ex)
Generated phoenix app
==> phoenix_live_reload
Compiling 4 files (.ex)
Generated phoenix_live_reload app
==> phoenix_live_view
Compiling 39 files (.ex)
Generated phoenix_live_view app
==> heroicons
Compiling 3 files (.ex)
Generated heroicons app
  use Phoenix.Component, global_prefixes: ~w(x-)

  attr(:label, :string, required: true)
  attr(:path, :string, required: true)
  attr(:icon, :string, required: true)
  attr(:active, :boolean, default: false)

  def sidebar_main_item(assigns) do
    ~H"""
    <.link navigate={@path} class={item_class(@active)} x-tooltip.placement.right={"'#{@label}'"}>
      <i class={"text-xl #{@icon}"}></i>
    </.link>
    """
  end

  defp item_class(false),
    do:
      "flex h-11 w-11 items-center justify-center rounded-lg outline-none transition-colors duration-200 hover:bg-primary/20 focus:bg-primary/20 active:bg-primary/25 dark:hover:bg-navy-300/20 dark:focus:bg-navy-300/20 dark:active:bg-navy-300/25"

  defp item_class(true),
    do:
      "flex h-11 w-11 items-center justify-center rounded-lg bg-primary/10 text-primary outline-none transition-colors duration-200 hover:bg-primary/20 focus:bg-primary/20 active:bg-primary/25 dark:bg-navy-600 dark:text-accent-light dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"
end
