defmodule Paleta.Components.Badges.Badge do
  use Phoenix.Component

  attr(:description, :string, default: nil)
  attr(:class, :string, default: "")
  slot(:inner_block, required: false)

  attr(:color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :info, :success, :warning, :error, :dark, :light]
  )

  def badge(%{color: color, class: custom_class} = assigns) do
    full_class = "#{custom_class} #{class(color)}"

    assigns =
      assigns
      |> assign(:class, full_class)

    ~H"""
    <span class={@class}><%= @description || render_slot(@inner_block) %></span>
    """
  end

  defp class(:default),
    do: "badge bg-slate-150 text-slate-800 dark:bg-navy-500 dark:text-navy-100"

  defp class(:primary),
    do: "badge bg-primary text-white dark:bg-accent"

  defp class(:secondary),
    do: "badge bg-secondary text-white"

  defp class(:info), do: "badge bg-info text-white"
  defp class(:success), do: "badge bg-success text-white"
  defp class(:warning), do: "badge bg-warning text-white"
  defp class(:error), do: "badge bg-error text-white"
  defp class(:dark), do: "badge bg-navy-700 text-white dark:bg-navy-900"
  defp class(:light), do: "badge bg-slate-150 text-slate-800"
end
