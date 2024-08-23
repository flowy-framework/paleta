defmodule Paleta.Components.Span do
  use Phoenix.Component

  @doc """
  Renders a text.
  """
  attr(:value, :any, default: nil)
  attr(:rest, :global)
  attr(:max_length, :integer, default: 50)
  slot(:inner_block, required: false)

  def span(assigns) do
    assigns =
      assigns
      |> truncate()

    ~H"""
    <span {@rest}><%= @value || render_slot(@inner_block) %></span>
    """
  end

  defp truncate(%{value: nil} = assigns), do: assigns

  defp truncate(%{value: value, max_length: max_length} = assigns) when is_binary(value) do
    assigns
    |> assign(
      :value,
      Paleta.Utils.StringHelper.truncate(value, max_length: max_length)
    )
  end

  defp truncate(assigns), do: assigns
end
