defmodule Paleta.Components.AdvanceSelect do
  use Phoenix.Component

  import Paleta.Components.FieldHelper
  import Paleta.Components.Error

  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:options, :list, required: true)
  attr(:required, :boolean, default: false)
  attr(:rest, :global)
  attr(:errors, :list, default: [])

  def advance_select(assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()
      |> encode_options()
      |> encode_items()

    ~H"""
    <label for={@name} class="block" id={"#{@name}-label"} phx-update="ignore">
      <span>Available Metros</span>
      <input
        id={@name}
        required={@required}
        value={@value}
        data-items={@items}
        data-options={@options}
        phx-hook="TomSelect"
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

  defp encode_items(%{value: value} = assigns) do
    assign(assigns, :items, Enum.join(value, ","))
  end
end
