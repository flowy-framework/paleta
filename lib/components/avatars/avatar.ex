defmodule Paleta.Components.Avatars.Avatar do
  @moduledoc """
  ## Example

      <.avatar
        type={:rounded}
      />
  """

  use Phoenix.Component

  attr(:type, :atom, values: [:rounded, :square, :squircle], default: :rounded)
  attr(:size, :string, default: "8")
  attr(:src, :string)
  attr(:class, :string, default: "")
  attr(:tooltip, :string, default: nil)

  def avatar(assigns) do
    assigns = assigns |> assign(:img_class, type(assigns.type))

    ~H"""
    <div class={"avatar size-#{@size} #{@class}"} x-tooltip.light={@tooltip && "'#{@tooltip}'"}>
      <img class={@img_class} src={@src} alt="avatar" />
    </div>
    """
  end

  defp type(:rounded), do: "rounded-full"
  defp type(:square), do: "rounded-lg"
  defp type(:squircle), do: "mask is-squircle"
end
