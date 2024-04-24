defmodule Paleta.Components.Editor do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error
  alias Paleta.Components.Input

  attr(:engine, :atom, default: :ace, values: [:ace, :prosemirror])
  attr(:value, :string, default: nil)
  attr(:name, :string, default: "editor-content")
  attr(:mode, :atom, default: :html, values: [:html, :yaml, :json])
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:errors, :list, default: [])
  attr(:class, :string, default: "")
  attr(:rest, :global)

  @spec editor(map) :: Phoenix.LiveView.Rendered.t()
  def editor(assigns) do
    assigns = assigns |> assign_basic_attrs()
    do_render(assigns)
  end

  defp do_render(%{engine: :ace, class: class} = assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        "editor-parent #{class}"
      )

    ~H"""
    <div id="editor" class={@class} phx-update="ignore" phx-hook="Editor" data-mode={@mode}>
      <div id="ace-editor" class="editor"><%= @value %></div>
    </div>
    <Input.hidden_input name={@name} value={@value} {@rest} />
    <.error :for={{msg, _ops} <- @errors}>
      <%= msg %>
    </.error>
    """
  end

  defp do_render(%{engine: :prosemirror, class: class} = assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        "relative #{class}"
      )

    ~H"""
    <div class="prosemirror-editor-wrapper">
      <div
        id="prosemirror-editor"
        class={@class}
        phx-update="ignore"
        phx-hook="ProsemirrorEditor"
        name={@name}
        {@rest}
      >
      </div>
      <Input.textarea label="" name="prosemirror-content" value={@value} class="hidden" />
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </div>
    """
  end
end
