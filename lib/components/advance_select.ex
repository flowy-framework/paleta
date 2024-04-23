defmodule Paleta.Components.AdvanceSelect do
  use Phoenix.Component

  import Paleta.Components.FieldHelper
  import Paleta.Components.Error

  attr(:name, :string, default: nil)
  attr(:value, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:options, :list, required: true)
  attr(:max_items, :integer, default: nil)
  attr(:required, :boolean, default: false)
  attr(:label, :string)
  attr(:rest, :global)
  attr(:errors, :list, default: [])
  attr(:order_field, :string, default: "name")
  attr(:order_field_order, :string, default: "asc")

  def advance_select(assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()
      |> encode_options()
      |> encode_items()

    ~H"""
    <label for={@name} class="block" id={"#{@name}-label"} phx-update="ignore">
      <span><%= @label %></span>
      <input
        id={@name}
        required={@required}
        value={@value}
        data-items={@items}
        data-options={@options}
        data-max_items={@max_items}
        phx-hook="TomSelect"
        data-order_field={@order_field}
        data-order_field_order={@order_field_order}
        name={@name}
        class="select"
        {@rest}
      />
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end

  defp encode_options(%{options: options} = assigns) do
    assign(assigns, :options, Jason.encode!(options))
  end

  defp encode_items(%{value: ""} = assigns) do
    assign(assigns, :items, "")
  end

  defp encode_items(%{value: value} = assigns) when is_binary(value) do
    assign(assigns, :items, value)
  end

  defp encode_items(%{value: value} = assigns) do
    assign(assigns, :items, Enum.join(value, ","))
  end
end
