defmodule Paleta.Components.Editor do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error
  alias Paleta.Components.Input

  attr(:engine, :atom, default: :ace, values: [:ace, :prosemirror, :trix])
  attr(:value, :string, default: nil)
  attr(:attachments_endpoint, :string, default: nil)
  attr(:name, :string, default: "editor-content")
  attr(:mode, :atom, default: :html, values: [:html, :yaml, :json])
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:errors, :list, default: [])
  attr(:class, :string, default: "")
  attr(:rest, :global)
  attr(:id, :string, default: "")

  @spec editor(map) :: Phoenix.LiveView.Rendered.t()
  def editor(assigns) do
    assigns
    |> assign_basic_attrs()
    |> do_render()
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
    <.errors errors={@errors} />
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
        data-hidden_id={@id}
        {@rest}
      >
      </div>
      <Input.textarea label="" field={@field} class="hidden" />
      <.errors errors={@errors} />
    </div>
    """
  end

  defp do_render(%{engine: :trix} = assigns) do
    ~H"""
    <Input.hidden_input
      id={@id}
      name={@name}
      value={@value}
      phx-hook="Trix"
      data-endpoint={@attachments_endpoint}
    />
    <div class={@class} id="paleta-trix-editor-container" phx-update="ignore">
      <trix-editor id="paleta-trix-editor" autofocus input={@id}></trix-editor>
    </div>
    <.errors errors={@errors} />
    """
  end
end
