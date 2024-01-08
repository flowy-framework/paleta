defmodule Paleta.Components.Editor do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error
  alias Paleta.Components.Input

  attr(:value, :string, default: nil)
  attr(:name, :string, default: "editor-content")
  attr(:mode, :atom, default: :html, values: [:html, :yaml, :json])
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:errors, :list, default: [])

  @spec editor(map) :: Phoenix.LiveView.Rendered.t()
  def editor(assigns) do
    assigns = assigns |> assign_basic_attrs()

    ~H"""
    <div id="editor" class="editor-parent" phx-update="ignore" phx-hook="Editor" data-mode={@mode}>
      <div id="ace-editor" class="editor"><%= @value %></div>
    </div>
    <Input.hidden_input name={@name} value={@value} />
    <.error :for={{msg, _ops} <- @errors}>
      <%= msg %>
    </.error>
    """
  end
end
