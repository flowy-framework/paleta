defmodule Paleta.Components.ActionButton do
  use Paleta, :component

  attr(:path, :string, required: true)
  attr(:type, :atom, default: :patch, values: [:navigate, :patch])
  attr(:format, :atom, default: :outlined, values: [:outlined, :rounded, :regular, :custom])
  attr(:label, :string, required: true)
  attr(:class, :string, default: "")
  attr(:rest, :global)

  def action_button(assigns) do
    assigns =
      assigns
      |> assign(:class, class(assigns) <> " #{assigns.class}")

    ~H"""
    <.link patch={@path} class={@class} {@rest}>
      <%= @label %>
    </.link>
    """
  end

  defp class(%{format: :outlined}),
    do:
      "btn border border-slate-300 font-medium text-slate-800 hover:bg-slate-150 focus:bg-slate-150 active:bg-slate-150/80 dark:border-navy-450 dark:text-navy-50 dark:hover:bg-navy-500 dark:focus:bg-navy-500 dark:active:bg-navy-500/90"

  defp class(%{format: :rounded}),
    do:
      "btn rounded-full bg-slate-150 font-medium text-slate-800 hover:bg-slate-200 focus:bg-slate-200 active:bg-slate-200/80 dark:bg-navy-500 dark:text-navy-50 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"

  defp class(%{format: :regular}),
    do:
      "btn bg-slate-150 font-medium text-slate-800 hover:bg-slate-200 focus:bg-slate-200 active:bg-slate-200/80 dark:bg-navy-500 dark:text-navy-50 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"

  defp class(%{format: _}),
    do: ""
end
