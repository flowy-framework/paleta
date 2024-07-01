defmodule Paleta.Components.Field do
  use Phoenix.Component
  alias Paleta.Components.CopyToClipboard
  alias Paleta.Components.FromNow
  alias Paleta.Utils.StringHelper

  attr(:value, :string, required: true)

  def id_field(assigns) do
    ~H"""
    <span>
      <span class="mr-1 font-semibold text-slate-700 sm:ml-2">
        ID:
      </span>
      <CopyToClipboard.copy_to_clipboard class="mb-2 text-xs leading-tight" value={@value} />
    </span>
    """
  end

  attr(:label, :string, required: true)
  attr(:value, :string, required: true)

  def date_field(assigns) do
    ~H"""
    <span>
      <span class="mr-1 font-semibold text-slate-700 sm:ml-2">
        <%= @label %>:
      </span>
      <FromNow.from_now value={@value} />
    </span>
    """
  end

  attr(:label, :string, required: true)
  attr(:value, :string, required: true)
  slot(:inner_block, required: false)

  def field(assigns) do
    ~H"""
    <span>
      <span class="mr-1 font-semibold text-slate-700 sm:ml-2">
        <%= @label %>:
      </span>
      <%= @value || render_slot(@inner_block) %>
    </span>
    """
  end

  attr(:value, :string, required: true)
  attr(:empty_value, :string, default: "")
  attr(:class, :string, default: "")
  attr(:size, :string, default: "prose-sm")

  def markdown_field(
        %{value: value, empty_value: empty_value, class: class, size: size} = assigns
      ) do
    assigns =
      assigns
      |> assign(:class, "prose dark:prose-invert #{size} #{class}")
      |> assign(:markdown, StringHelper.markdown_to_html(value || empty_value))

    ~H"""
    <div class={"#{@class}"}>
      <%= Phoenix.HTML.raw(@markdown) %>
    </div>
    """
  end

  attr(:value, :string, required: true)
  attr(:class, :string, default: "")

  def html_field(%{value: value} = assigns) do
    # TODO: We might want to sanitize the HTML here
    # maybe using https://github.com/rrrene/html_sanitize_ex
    assigns =
      assigns
      |> assign(:html, value)

    ~H"""
    <div class={"#{@class}"}>
      <%= Phoenix.HTML.raw(@html) %>
    </div>
    """
  end
end
