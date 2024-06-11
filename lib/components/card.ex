defmodule Paleta.Components.Card do
  use Phoenix.Component

  alias Paleta.Utils.StringHelper
  alias Paleta.Utils.DateHelper

  attr(:color, :atom, default: :default, values: [:default, :success, :warning, :error])
  attr(:title, :string, default: nil)
  attr(:description, :string, default: nil)
  attr(:class, :string, default: "")
  attr(:id, :string, default: nil)

  attr(:title_class, :string, default: "text-lg font-medium tracking-wide line-clamp-1")

  slot(:inner_block, required: false)
  slot(:title_actions, required: false)

  def card(%{color: color, class: class, title_class: title_class} = assigns) do
    assigns =
      assigns
      |> assign(:class, "#{class(color)} #{class}")
      |> assign(:title_class, "#{title_class} #{title_class(color)}")

    ~H"""
    <div class={@class} id={@id}>
      <div :if={@title} class="flex items-center justify-between h-8 my-3">
        <h2 class={@title_class}>
          <%= @title %>
        </h2>
        <div :if={@title_actions} class="inline-flex">
          <%= render_slot(@title_actions) %>
        </div>
      </div>
      <div class="pt-2">
        <p :if={@description}>
          <%= @description %>
        </p>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  attr(:color, :atom, default: :default, values: [:default, :success, :warning, :error])
  attr(:class, :string, default: "")
  attr(:id, :string, default: nil)
  slot(:inner_block, required: false)

  def simple_card(%{color: color, class: class} = assigns) do
    assigns =
      assigns
      |> assign(:class, "#{class(color)} #{class}")

    ~H"""
    <div class={@class} id={@id}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp title_class(:default), do: "text-slate-700 dark:text-navy-100"
  defp title_class(_), do: "text-white"

  attr(:title, :string, required: true)
  attr(:description, :string, default: "")
  slot(:inner_block, required: true)

  def card_fields_group(assigns) do
    ~H"""
    <div class="px-4 pb-5 rounded-lg bg-info/10 dark:bg-navy-800 sm:px-5">
      <div class="py-3 space-y-4">
        <div>
          <h3 class="text-lg font-medium text-slate-700 dark:text-navy-100">
            <%= @title %>
          </h3>
          <p class="text-xs text-slate-400 dark:text-navy-300">
            <%= @description %>
          </p>
        </div>
        <div class="space-y-3 text-xs+">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  attr(:label, :string, required: true)
  attr(:value, :string, default: nil)
  slot(:inner_block, required: false)

  def card_field(assigns) do
    ~H"""
    <div class="flex justify-between">
      <p class="line-clamp-1 text-slate-700 dark:text-navy-100">
        <%= @label %>
      </p>
      <p class="text-right"><%= @value || render_slot(@inner_block) %></p>
    </div>
    """
  end

  attr(:label, :string, required: true)
  slot(:inner_block, required: false)

  def card_field_block(assigns) do
    ~H"""
    <div class="flex justify-between">
      <p class="line-clamp-1 text-slate-700 dark:text-navy-100">
        <%= @label %>
      </p>
      <div class="text-right"><%= render_slot(@inner_block) %></div>
    </div>
    """
  end

  attr(:value, :string, default: nil)
  slot(:inner_block, required: false)

  def card_paragraph(assigns) do
    ~H"""
    <div class="flex justify-start">
      <%= @value || render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:label, :string, required: true)
  attr(:icon_class, :string, required: true)
  attr(:tooltip, :string, default: "")

  def card_icon_field(assigns) do
    ~H"""
    <div class="flex justify-between">
      <p class="line-clamp-1 text-slate-700 dark:text-navy-100" x-tooltip.light={"'#{@tooltip}'"}>
        <%= @label %>
      </p>
      <p class="text-right">
        <i class={@icon_class} />
      </p>
    </div>
    """
  end

  def card_line(assigns) do
    ~H"""
    <div class="h-px my-3 bg-slate-200 dark:bg-navy-500"></div>
    """
  end

  attr(:label, :string, required: true)
  attr(:value, :string, required: true)
  attr(:format, :string, default: "date_from_now", values: ["date_from_now", "short_id"])

  def card_formatted_field(%{format: "date_from_now", value: value} = assigns) do
    assigns
    |> assign(:value, DateHelper.from_now(value))
    |> _card_formatted_field()
  end

  def card_formatted_field(%{format: "short_id", value: value} = assigns) do
    assigns
    |> assign(:value, StringHelper.short_id(value))
    |> _card_formatted_field()
  end

  defp _card_formatted_field(assigns) do
    ~H"""
    <.card_field value={@value} label={@label} />
    """
  end

  defp class(:default), do: "card px-4 py-4 sm:px-5"
  defp class(:warning), do: "rounded-lg bg-warning px-4 py-4 text-white sm:px-5"
  defp class(:success), do: "rounded-lg bg-success px-4 py-4 text-white sm:px-5"
  defp class(:error), do: "rounded-lg bg-error px-4 py-4 text-white sm:px-5"
end
