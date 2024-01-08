defmodule Paleta.Components.Span do
  use Phoenix.Component

  @doc """
  Renders a text.
  """
  attr(:value, :string, default: nil)
  attr(:max_length, :integer, default: 50)

  def span(assigns) do
    assigns =
      assigns
      |> assign(
        :value,
        Paleta.Utils.StringHelper.truncate(assigns.value, max_length: assigns.max_length)
      )

    ~H"""
    <span><%= @value %></span>
    """
  end
end
