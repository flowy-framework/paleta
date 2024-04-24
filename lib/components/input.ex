defmodule Paleta.Components.Input do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error

  attr(:label, :string, default: nil)
  attr(:id, :string, default: nil)
  attr(:name, :string, default: nil)
  attr(:type, :string, default: "text")
  attr(:value, :string, default: nil)
  attr(:class, :string, default: "")
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:required, :boolean, default: false)
  attr(:placeholder, :string, default: "")
  attr(:rest, :global, include: ~w(disabled readonly))
  attr(:errors, :list, default: [])

  def text(%{class: class} = assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()
      |> assign(
        :class,
        "form-input mt-1.5 w-full rounded-lg border border-slate-300 bg-transparent px-3 py-2 placeholder:text-slate-400/70 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent #{class}"
      )

    ~H"""
    <label for={@id} class="block">
      <span :if={@label}><%= @label %><span :if={@required} class="ml-1">*</span></span>
      <input
        required={@required}
        type={@type}
        value={@value}
        name={@name}
        id={@id}
        placeholder={@placeholder}
        class={@class}
        {@rest}
      />
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end

  def input(assigns) do
    text(assigns)
  end

  attr(:label, :string, required: true)
  attr(:id, :string, default: nil)
  attr(:name, :string, default: nil)
  attr(:type, :string, default: "text")
  attr(:value, :string, default: nil)
  attr(:required, :boolean, default: false)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:placeholder, :string, default: "")
  attr(:class, :string, default: "")
  attr(:rest, :global)
  attr(:errors, :list, default: [])
  slot(:sufix, required: true)

  def input_group(%{class: class} = assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()
      |> assign(
        :class,
        "form-input w-full rounded-l-lg border border-slate-300 bg-transparent px-3 py-2 placeholder:text-slate-400/70 hover:z-10 hover:border-slate-400 focus:z-10 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent #{class}"
      )

    ~H"""
    <div>
      <span><%= @label %><span :if={@required} class="ml-1">*</span></span>
      <label for={@name} class="mt-1.5 flex -space-x-px">
        <input
          required={@required}
          type={@type}
          value={@value}
          name={@name}
          id={@id}
          placeholder={@placeholder}
          class={@class}
          {@rest}
        />
        <span class="flex items-center justify-center rounded-r-lg border border-slate-300 px-3.5 font-inter dark:border-navy-450">
          <%= render_slot(@sufix) %>
        </span>
      </label>
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </div>
    """
  end

  attr(:label, :string, required: true)
  attr(:id, :string, required: true)
  attr(:name, :string, required: true)
  attr(:value, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:required, :boolean, default: false)
  attr(:placeholder, :string, default: "")
  attr(:rest, :global)
  attr(:errors, :list, default: [])

  def datepicker(assigns) do
    assigns = assigns |> assign_basic_attrs()

    ~H"""
    <label id={"pick-#{@id}"} for={@id} class="block flatpickr" phx-update="ignore" phx-hook="Pickr">
      <span><%= @label %><span :if={@required} class="ml-1">*</span></span>
      <input
        required={@required}
        type="text"
        value={@value}
        name={@name}
        id={@id}
        placeholder={@placeholder}
        data-input
        data-time_only="false"
        class="form-input mt-1.5 w-full rounded-lg border border-slate-300 bg-transparent px-3 py-2 placeholder:text-slate-400/70 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent"
        {@rest}
      />
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end

  attr(:label, :string, required: true)
  attr(:id, :string, required: true)
  attr(:name, :string, required: true)
  attr(:value, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:required, :boolean, default: false)
  attr(:placeholder, :string, default: "")
  attr(:rest, :global)
  attr(:errors, :list, default: [])

  def timepicker(assigns) do
    assigns = assigns |> assign_basic_attrs()

    ~H"""
    <label id={"pick-#{@id}"} for={@id} class="block flatpickr" phx-update="ignore">
      <span><%= @label %><span :if={@required} class="ml-1">*</span></span>
      <input
        phx-hook="Pickr"
        data-time_only="true"
        required={@required}
        type="text"
        value={@value}
        name={@name}
        id={@id}
        placeholder={@placeholder}
        data-input
        class="form-input mt-1.5 w-full rounded-lg border border-slate-300 bg-transparent px-3 py-2 placeholder:text-slate-400/70 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent"
        {@rest}
      />
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end

  attr(:id, :string, default: nil)
  attr(:name, :string, default: nil)
  attr(:value, :string)
  attr(:rest, :global)
  attr(:field, Phoenix.HTML.FormField, default: nil)

  def hidden_input(assigns) do
    assigns = assigns |> assign_basic_attrs()

    ~H"""
    <input type="hidden" value={@value} name={@name} id={@id} {@rest} />
    """
  end

  attr(:label, :string, required: true)
  attr(:id, :string, default: nil)
  attr(:name, :string, default: nil)
  attr(:value, :string, default: nil)
  attr(:class, :string, default: "")
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:placeholder, :string, default: "")
  attr(:rows, :integer, default: 4)
  attr(:required, :boolean, default: false)
  attr(:rest, :global, include: ~w(required disabled))
  attr(:errors, :list, default: [])

  def textarea(%{class: class} = assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()
      |> assign(
        :class,
        "form-textarea mt-1.5 w-full resize-none rounded-lg border border-slate-300 bg-transparent p-2.5 placeholder:text-slate-400/70 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent #{class}"
      )

    ~H"""
    <label class="block">
      <span>
        <%= @label %><span :if={@required} class="ml-1">*</span>
      </span>
      <textarea
        required={@required}
        name={@name}
        id={@id}
        rows={@rows}
        placeholder={@placeholder}
        class={@class}
        {@rest}
      ><%= @value %></textarea>
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end
end
