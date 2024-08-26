defmodule Paleta.Components.Alert do
  use Paleta, :component

  attr(:description, :string, default: nil)
  attr(:class, :string, default: "")
  attr(:icon, :string, default: nil)
  attr(:type, :atom, values: [:basic, :outline, :outline_round], default: :basic)
  slot(:inner_block, required: false)

  attr(:color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :info, :success, :warning, :error, :dark, :light]
  )

  def alert(%{color: color, class: custom_class, type: type} = assigns) do
    full_class = "#{custom_class} #{class(type, color)}"

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

  defp class(:basic, :default),
    do:
      "alert flex rounded-lg bg-slate-200 px-4 py-4 text-slate-600 dark:bg-navy-500 dark:text-navy-100 sm:px-5"

  defp class(:basic, :primary),
    do: "alert flex rounded-lg bg-primary px-4 py-4 text-white dark:bg-accent sm:px-5"

  defp class(:basic, :secondary),
    do: "alert flex rounded-lg bg-secondary px-4 py-4 text-white sm:px-5"

  defp class(:basic, :info), do: "alert flex rounded-lg bg-info px-4 py-4 text-white sm:px-5"

  defp class(:basic, :success),
    do: "alert flex rounded-lg bg-success px-4 py-4 text-white sm:px-5"

  defp class(:basic, :warning),
    do: "alert flex rounded-lg bg-warning px-4 py-4 text-white sm:px-5"

  defp class(:basic, :error), do: "alert flex rounded-lg bg-error px-4 py-4 text-white sm:px-5"

  ######### Outline Round #########
  defp class(:outline_round, :default),
    do: class(:outline_round, :primary)

  defp class(:outline_round, :primary),
    do: "alert flex rounded-lg bg-primary px-4 py-4 text-white dark:bg-accent sm:px-5"

  defp class(:outline_round, :secondary),
    do:
      "alert flex rounded-full bg-secondary/10 py-4 px-4 text-secondary dark:bg-secondary-light/15 dark:text-secondary-light sm:px-5"

  defp class(:outline_round, :info),
    do: "alert flex rounded-full bg-info/10 py-4 px-4 text-info dark:bg-info/15 sm:px-5"

  defp class(:outline_round, :success),
    do: "alert flex rounded-full bg-success/10 py-4 px-4 text-success dark:bg-success/15 sm:px-5"

  defp class(:outline_round, :warning),
    do: "alert flex rounded-full bg-warning/10 py-4 px-4 text-warning dark:bg-warning/15 sm:px-5"

  defp class(:outline_round, :error),
    do: "alert flex rounded-full bg-error/10 py-4 px-4 text-error dark:bg-error/15 sm:px-5"

  ######### Outline #########
  defp class(:outline, :default),
    do:
      "alert flex rounded-lg border border-slate-300 px-4 py-4 text-slate-800 dark:border-navy-450 dark:text-navy-50 sm:px-5"

  defp class(:outline, :primary),
    do:
      "alert flex rounded-lg border border-primary px-4 py-4 text-primary dark:border-accent dark:text-accent-light sm:px-5"

  defp class(:outline, :secondary),
    do:
      "alert flex rounded-lg border border-secondary px-4 py-4 text-secondary dark:border-secondary dark:text-secondary-light sm:px-5"

  defp class(:outline, :info),
    do: "alert flex rounded-lg border border-info px-4 py-4 text-info sm:px-5"

  defp class(:outline, :success),
    do: "alert flex rounded-lg border border-success px-4 py-4 text-success sm:px-5"

  defp class(:outline, :warning),
    do: "alert flex rounded-lg border border-warning px-4 py-4 text-warning sm:px-5"

  defp class(:outline, :error),
    do: "alert flex rounded-lg border border-error px-4 py-4 text-error sm:px-5"
end
