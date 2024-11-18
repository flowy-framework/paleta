defmodule Paleta.Components.Link do
  use Paleta, :component

  alias Paleta.Components.ShortId

  attr(:path, :string, required: true)
  attr(:icon, :string, default: "")
  attr(:tooltip, :string, default: nil)
  attr(:rest, :global)
  attr(:permission, :string, default: "")
  attr(:permissions, :any, default: [])
  slot(:inner_block, required: false)

  def external_link(assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        "btn h-8 w-8 p-0 hover:bg-info/20 focus:bg-info/20 active:bg-info/25"
      )
      |> assign(:type, :href)
      |> assign(:target, "_blank")

    Paleta.Auth.Restricter.do_render(__MODULE__, :_do_link, assigns)
  end

  attr(:path, :string, required: true)
  slot(:inner_block, required: false)
  attr(:type, :atom, default: :patch, values: [:href, :patch, :navigate])
  attr(:rest, :global)
  attr(:permission, :string, default: "")
  attr(:permissions, :any, default: [])
  attr(:tooltip, :string, default: nil)

  def view_link(assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        "btn h-8 w-8 p-0 text-info hover:bg-info/20 focus:bg-info/20 active:bg-info/25"
      )
      |> assign(:icon, "fa-regular fa-eye")
      |> assign(:target, nil)

    Paleta.Auth.Restricter.do_render(__MODULE__, :_do_link, assigns)
  end

  attr(:path, :string, required: true)
  slot(:inner_block, required: false)
  attr(:type, :atom, default: :patch)
  attr(:class, :string, default: "")
  attr(:rest, :global)
  attr(:permission, :string, default: "")
  attr(:permissions, :any, default: [])
  attr(:tooltip, :string, default: nil)

  def delete_link(%{class: class} = assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        "btn h-8 w-8 p-0 text-error hover:bg-error/20 focus:bg-error/20 active:bg-error/25 #{class}"
      )
      |> assign(:icon, "fa fa-trash-alt")
      |> assign(:target, nil)

    Paleta.Auth.Restricter.do_render(__MODULE__, :_do_link, assigns)
  end

  attr(:path, :string, required: true)
  slot(:inner_block, required: false)
  attr(:type, :atom, default: :patch, values: [:patch, :navigate])
  attr(:rest, :global)
  attr(:permission, :string, default: "")
  attr(:permissions, :any, default: [])
  attr(:tooltip, :string, default: nil)

  def edit_link(assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        "btn h-8 w-8 p-0 text-info hover:bg-info/20 focus:bg-info/20 active:bg-info/25"
      )
      |> assign(:icon, "fa fa-edit")
      |> assign(:target, nil)

    Paleta.Auth.Restricter.do_render(__MODULE__, :_do_link, assigns)
  end

  attr(:path, :string, required: true)
  attr(:id, :string, required: true)
  attr(:rest, :global)
  attr(:permission, :string)
  attr(:permissions, :any, default: [])

  def id_link(assigns) do
    Paleta.Auth.Restricter.do_render(__MODULE__, :_do_id_link, assigns)
  end

  def _do_id_link(assigns) do
    ~H"""
    <.link
      navigate={@path}
      class="transition-colors text-primary hover:text-primary-focus dark:text-accent-light dark:hover:text-accent"
    >
      <ShortId.short_id value={@id} />
    </.link>
    """
  end

  @doc """
  Renders a back navigation link.

  ## Examples

      <.back_link navigate={~p"/posts"}>Back to posts</.back_link>
  """
  attr(:navigate, :any, required: true)
  slot(:inner_block, required: true)

  def back_link(assigns) do
    ~H"""
    <div class="mt-16">
      <.link
        navigate={@navigate}
        class="text-sm font-semibold leading-6 text-zinc-900 hover:text-zinc-700"
      >
        <Paleta.Components.Icon.icon name="hero-arrow-left-solid" class="w-3 h-3" />
        <%= render_slot(@inner_block) %>
      </.link>
    </div>
    """
  end

  def _do_link(%{type: :href} = assigns) do
    ~H"""
    <.link
      href={@path}
      target={@target}
      x-tooltip.light={@tooltip && "'#{@tooltip}'"}
      class={@class}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
      <i class={@icon}></i>
    </.link>
    """
  end

  def _do_link(%{type: :patch} = assigns) do
    ~H"""
    <.link patch={@path} x-tooltip.light={@tooltip && "'#{@tooltip}'"} class={@class} {@rest}>
      <i class={@icon}></i>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def _do_link(%{type: :navigate} = assigns) do
    ~H"""
    <.link navigate={@path} x-tooltip.light={@tooltip && "'#{@tooltip}'"} class={@class} {@rest}>
      <i class={@icon}></i>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end
end
