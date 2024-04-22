defmodule Paleta.Components.Editor do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error
  alias Paleta.Components.Input

  attr(:engine, :atom, default: :ace, values: [:ace, :quill, :milkdown])
  attr(:value, :string, default: nil)
  attr(:name, :string, default: "editor-content")
  attr(:mode, :atom, default: :html, values: [:html, :yaml, :json])
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:errors, :list, default: [])
  attr(:rest, :global)

  @spec editor(map) :: Phoenix.LiveView.Rendered.t()
  def editor(assigns) do
    assigns = assigns |> assign_basic_attrs()

    do_render(assigns)
  end

  defp do_render(%{engine: :ace} = assigns) do
    ~H"""
    <div id="editor" class="editor-parent" phx-update="ignore" phx-hook="Editor" data-mode={@mode}>
      <div id="ace-editor" class="editor"><%= @value %></div>
    </div>
    <Input.hidden_input name={@name} value={@value} {@rest} />
    <.error :for={{msg, _ops} <- @errors}>
      <%= msg %>
    </.error>
    """
  end

  defp do_render(%{engine: :quill} = assigns) do
    ~H"""
    <div id="editor" phx-hook="TextEditor" name={@name} {@rest}><%= Phoenix.HTML.raw(@value) %></div>
    <Input.hidden_input name="editor-content" value={@value} />
    <.error :for={{msg, _ops} <- @errors}>
      <%= msg %>
    </.error>
    """
  end

  defp do_render(%{engine: :milkdown} = assigns) do
    ~H"""
    <div id="richt-editor" class="relative" phx-update="ignore" phx-hook="MilkdownEditor" name={@name} {@rest}></div>
    <Input.hidden_input name="editor-content" value={@value} />
    <.error :for={{msg, _ops} <- @errors}>
      <%= msg %>
    </.error>
    """
  end
end
