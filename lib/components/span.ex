defmodule Paleta.Components.Span do
  use Phoenix.Component

  @doc """
  Renders a text.
  """
  attr(:value, :string, default: nil)
  attr(:rest, :global)
  attr(:max_length, :integer, default: 50)

  def span(assigns) do
    assigns =
      assigns
      |> truncate()

    ~H"""
    <span {@rest}><%= @value %></span>
    """
  end

  defp truncate(%{value: nil} = assigns), do: assigns

  defp truncate(%{value: value, max_length: max_length} = assigns) do
    assigns
    |> assign(
      :value,
      Paleta.Utils.StringHelper.truncate(value, max_length: max_length)
    )
  end
end
