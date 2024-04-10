defmodule Paleta.Components.Checkbox do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error

  attr(:name, :string, default: "")
  attr(:value, :string, default: nil)
  attr(:rest, :global, include: ~w(checked))
  attr(:class, :string, default: "")
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:label, :string, required: true)
  attr(:errors, :list, default: [])

  attr(:color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :info, :success, :warning, :error, :dark, :light]
  )

  def checkbox(assigns), do: outline_circle_checkbox(assigns)

  attr(:name, :string, default: "")
  attr(:value, :string, default: nil)
  attr(:rest, :global, include: ~w(checked))
  attr(:class, :string, default: "")
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:label, :string, required: true)
  attr(:errors, :list, default: [])

  attr(:color, :atom,
    default: :default,
    values: [:default, :primary, :secondary, :info, :success, :warning, :error, :dark, :light]
  )

  def outline_circle_checkbox(assigns) do
    assigns
    |> assign(:type, :outline_circle)
    |> do_render_check()
  end

  defp do_render_check(%{color: color, class: custom_class, type: type, value: value} = assigns) do
    full_class = "#{custom_class} #{class(color, type)}"

    assigns =
      assigns
      |> assign_basic_attrs()
      |> assign(:checked, normalize_value(value))
      |> assign(:class, full_class)

    ~H"""
    <label class="inline-flex items-center space-x-2">
      <input type="checkbox" value={@value} name={@name} class={@class} checked={@checked} {@rest} />
      <p><%= @label %></p>
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end

  defp normalize_value(%Phoenix.HTML.FormField{value: value}), do: normalize_value(value)

  defp normalize_value(true), do: true

  defp normalize_value(value) do
    Phoenix.HTML.Form.normalize_value("checkbox", value)
  end

  defp class(:default, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:bg-slate-500 checked:border-slate-500 hover:border-slate-500 focus:border-slate-500 dark:border-navy-400 dark:before:bg-navy-200 dark:checked:border-navy-200 dark:hover:border-navy-200 dark:focus:border-navy-200"

  defp class(:primary, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:bg-primary checked:border-primary hover:border-primary focus:border-primary dark:border-navy-400 dark:before:bg-accent dark:checked:border-accent dark:hover:border-accent dark:focus:border-accent"

  defp class(:secondary, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:bg-secondary checked:border-secondary hover:border-secondary focus:border-secondary dark:border-navy-400 dark:before:bg-secondary-light dark:checked:border-secondary-light dark:hover:border-secondary-light dark:focus:border-secondary-light"

  defp class(:info, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:!bg-info checked:!border-info hover:!border-info focus:!border-info dark:border-navy-400"

  defp class(:success, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:!bg-success checked:!border-success hover:!border-success focus:!border-success dark:border-navy-400"

  defp class(:warning, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:!bg-warning checked:!border-warning hover:!border-warning focus:!border-warning dark:border-navy-400"

  defp class(:error, :outline_circle),
    do:
      "form-checkbox is-outline h-5 w-5 rounded-full border-slate-400/70 before:!bg-error checked:!border-error hover:!border-error focus:!border-error dark:border-navy-400"
end
