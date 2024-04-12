defmodule Paleta.Components.Alert do
  use Phoenix.Component

  attr(:description, :string, default: nil)
  attr(:class, :string, default: "")
  attr(:icon, :string, default: nil)
  slot(:inner_block, required: false)

  attr(:color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :info, :success, :warning, :error, :dark, :light]
  )

  def alert(%{color: color, class: custom_class} = assigns) do
    full_class = "#{custom_class} #{class(color)}"

    assigns =
      assigns
      |> assign(:class, full_class)

    _alert(assigns)
  end

  defp _alert(%{icon: nil} = assigns) do
    ~H"""
    <div class={@class}>
      <p><%= @description || render_slot(@inner_block) %></p>
    </div>
    """
  end

  defp _alert(assigns) do
    ~H"""
    <div class={@class}>
      <div class="flex items-center flex-1 space-x-3">
        <i class={@icon}></i>
        <p><%= @description || render_slot(@inner_block) %></p>
      </div>
    </div>
    """
  end

  defp class(:default),
    do:
      "alert flex rounded-lg bg-slate-200 px-4 py-4 text-slate-600 dark:bg-navy-500 dark:text-navy-100 sm:px-5"

  defp class(:primary),
    do: "alert flex rounded-lg bg-primary px-4 py-4 text-white dark:bg-accent sm:px-5"

  defp class(:secondary),
    do: "alert flex rounded-lg bg-secondary px-4 py-4 text-white sm:px-5"

  defp class(:info), do: "alert flex rounded-lg bg-info px-4 py-4 text-white sm:px-5"
  defp class(:success), do: "alert flex rounded-lg bg-success px-4 py-4 text-white sm:px-5"
  defp class(:warning), do: "alert flex rounded-lg bg-warning px-4 py-4 text-white sm:px-5"
  defp class(:error), do: "alert flex rounded-lg bg-error px-4 py-4 text-white sm:px-5"
end
