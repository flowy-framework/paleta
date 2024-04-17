defmodule Paleta.Components.Input do
  use Phoenix.Component
  import Paleta.Components.FieldHelper
  import Paleta.Components.Error

  attr(:label, :string, default: nil)
  attr(:name, :string, default: nil)
  attr(:type, :string, default: "text")
  attr(:value, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:required, :boolean, default: false)
  attr(:placeholder, :string, default: "")
  attr(:class, :string, default: "")
  attr(:rest, :global, include: ~w(disabled readonly))
  attr(:errors, :list, default: [])
  attr(:multiple, :boolean, default: false)

  def text(%{class: class} = assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()
      |> assign(
        :class,
        "form-input mt-1.5 w-full rounded-lg border border-slate-300 bg-transparent px-3 py-2 placeholder:text-slate-400/70 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent #{class}"
      )

    ~H"""
    <label for={@name} class="block">
      <span :if={@label}><%= @label %><span :if={@required} class="ml-1">*</span></span>
      <input
        required={@required}
        type={@type}
        value={@value}
        name={@name}
        id={@name}
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

  def input(%{type: "checkgroup"} = assigns) do
    assigns =
      assigns
      |> assign_basic_attrs()

    ~H"""
    <div phx-feedback-for={@name} class="text-sm">
      <div class="w-full py-2 pl-3 pr-10 mt-1 text-left bg-white border border-gray-300 rounded-md shadow-sm cursor-default focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
        <div class="grid items-baseline grid-cols-1 gap-1 text-sm">
          <input type="hidden" name={@name} value="" />
          <div :for={{label, value} <- @options} class="flex items-center">
            <label for={"#{@name}-#{value}"} class="font-medium text-gray-700">
              <input
                type="checkbox"
                id={"#{@name}-#{value}"}
                name={@name}
                value={value}
                checked={value in @value}
                class="w-4 h-4 mr-2 text-indigo-600 transition duration-150 ease-in-out border-gray-300 rounded focus:ring-indigo-500"
                {@rest}
              />
              <%= label %>
            </label>
          </div>
        </div>
      </div>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  # ...

  @doc """
  Generate a checkbox group for multi-select.
  """
  attr(:id, :any)
  attr(:name, :any)
  attr(:label, :string, default: nil)

  attr(:field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"
  )

  attr(:errors, :list, default: [])
  attr(:options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2")
  attr(:rest, :global, include: ~w(disabled form readonly))
  attr(:class, :string, default: nil)
  attr(:value, :list, default: [])

  def checkgroup(assigns) do
    new_assigns =
      assigns
      |> assign(:multiple, true)
      |> assign(:type, "checkgroup")

    input(new_assigns)
  end

  def input(assigns) do
    text(assigns)
  end

  attr(:label, :string, required: true)
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
          id={@name}
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
    <label
      id={"pick-#{@name}"}
      for={@name}
      class="block flatpickr"
      phx-update="ignore"
      phx-hook="Pickr"
    >
      <span><%= @label %><span :if={@required} class="ml-1">*</span></span>
      <input
        required={@required}
        type="text"
        value={@value}
        name={@name}
        id={@name}
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

  attr(:name, :string, default: nil)
  attr(:value, :string)
  attr(:rest, :global)
  attr(:required, :boolean, default: false)
  attr(:field, Phoenix.HTML.FormField, default: nil)

  def hidden_input(assigns) do
    assigns = assigns |> assign_basic_attrs()

    ~H"""
    <input type="hidden" value={@value} name={@name} id={@name} required={@required} {@rest} />
    """
  end

  attr(:label, :string, required: true)
  attr(:name, :string, default: nil)
  attr(:value, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:placeholder, :string, default: "")
  attr(:rows, :integer, default: 4)
  attr(:required, :boolean, default: false)
  attr(:rest, :global, include: ~w(required disabled))
  attr(:errors, :list, default: [])

  def textarea(assigns) do
    assigns = assigns |> assign_basic_attrs()

    ~H"""
    <label class="block">
      <span>
        <%= @label %><span :if={@required} class="ml-1">*</span>
      </span>
      <textarea
        required={@required}
        name={@name}
        id={@name}
        rows={@rows}
        placeholder={@placeholder}
        class="form-textarea mt-1.5 w-full resize-none rounded-lg border border-slate-300 bg-transparent p-2.5 placeholder:text-slate-400/70 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:hover:border-navy-400 dark:focus:border-accent"
        {@rest}
      ><%= @value %></textarea>
      <.error :for={{msg, _ops} <- @errors}>
        <%= msg %>
      </.error>
    </label>
    """
  end
end
