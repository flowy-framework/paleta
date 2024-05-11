defmodule Paleta.Components.Form do
  @moduledoc """
  A simple form component that wraps a form tag and provides a default layout
  """

  use Phoenix.Component

  slot(:inner_block, required: true)

  slot(:actions, required: false) do
    attr(:align, :atom, values: [:left, :center, :right])
    attr(:class, :string)
  end

  attr(:for, :any, default: %{})
  attr(:as, :atom, default: :form)
  attr(:event, :string, default: "save")
  attr(:target, :map, default: nil)
  attr(:container_class, :string, default: "px-4 py-4 sm:px-5")
  attr(:inner_class, :string, default: "space-y-4")

  attr(:rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target),
    doc: "the arbitrary HTML attributes to apply to the form tag"
  )

  @doc """
  Renders a simple form with a default layout.

  ## Examples

      <.simple_form>
  """
  def simple_form(%{actions: []} = assigns) do
    assigns
    |> assign(:actions_align, :right)
    |> assign(:actions_class, :right)
    |> do_simple_form()
  end

  def simple_form(%{actions: [actions]} = assigns) do
    assigns
    |> assign(:actions_align, Map.get(actions, :align, :right))
    |> assign(:actions_class, Map.get(actions, :class, ""))
    |> do_simple_form()
  end

  defp do_simple_form(assigns) do
    ~H"""
    <div class={@container_class}>
      <.form
        :let={f}
        for={@for}
        as={@as}
        phx-submit={@event}
        phx-target={@target}
        role="form text-left"
        {@rest}
      >
        <div class={@inner_class}>
          <%= render_slot(@inner_block, f) %>
          <div class={"space-x-2 text-#{@actions_align} #{@actions_class}"}>
            <%= render_slot(@actions || %{}, f) %>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  slot(:inner_block, required: true)

  def form_actions(assigns) do
    ~H"""
    <div class="space-x-2 text-right">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:label, :string, default: "Cancel")
  attr(:cancel_url, :string, default: "/")
  attr(:type, :atom, default: :link, values: [:btn, :link])
  attr(:rest, :global)

  def cancel_button(assigns) do
    do_render_cancel_button(assigns)
  end

  def do_render_cancel_button(%{type: :link} = assigns) do
    ~H"""
    <.link
      navigate={@cancel_url}
      class="btn min-w-[7rem] rounded-full border border-slate-300 font-medium text-slate-800 hover:bg-slate-150 focus:bg-slate-150 active:bg-slate-150/80 dark:border-navy-450 dark:text-navy-50 dark:hover:bg-navy-500 dark:focus:bg-navy-500 dark:active:bg-navy-500/90"
      {@rest}
    >
      <%= @label %>
    </.link>
    """
  end

  def do_render_cancel_button(%{type: :btn} = assigns) do
    ~H"""
    <button
      type="button"
      class="btn min-w-[7rem] rounded-full border border-slate-300 font-medium text-slate-800 hover:bg-slate-150 focus:bg-slate-150 active:bg-slate-150/80 dark:border-navy-450 dark:text-navy-50 dark:hover:bg-navy-500 dark:focus:bg-navy-500 dark:active:bg-navy-500/90"
      {@rest}
    >
      <%= @label %>
    </button>
    """
  end

  attr(:label, :string, default: "Save")
  attr(:in_progress_label, :string, default: "Saving...")
  attr(:rest, :global, include: ~w(disabled))

  attr(:class, :string,
    default:
      "btn min-w-[7rem] rounded-full bg-primary font-medium text-white hover:bg-primary-focus focus:bg-primary-focus active:bg-primary-focus/90 dark:bg-accent dark:hover:bg-accent-focus dark:focus:bg-accent-focus dark:active:bg-accent/90"
  )

  def save_button(assigns) do
    ~H"""
    <button
      id="save-button"
      type="submit"
      phx-disable-with={@in_progress_label}
      class={@class}
      {@rest}
    >
      <svg
        role="status"
        class="inline w-4 h-4 mr-3 text-white while-submitting animate-spin"
        viewBox="0 0 100 101"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
          fill="#E5E7EB"
        />
        <path
          d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
          fill="currentColor"
        />
      </svg>
      <%= @label %>
    </button>
    """
  end

  attr(:label, :string, default: "Delete")
  attr(:in_progress_label, :string, default: "Deleting...")

  def delete_button(assigns) do
    ~H"""
    <button
      id="delete-button"
      type="submit"
      phx-disable-with=""
      class="btn min-w-[7rem] rounded-full bg-error font-medium text-white hover:bg-error-focus focus:bg-error-focus active:bg-error-focus/90 dark:bg-error dark:hover:bg-error-focus dark:focus:bg-error-focus dark:active:bg-error/90"
    >
      <svg
        role="status"
        class="inline w-4 h-4 mr-3 text-white while-submitting animate-spin"
        viewBox="0 0 100 101"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
          fill="#E5E7EB"
        />
        <path
          d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
          fill="currentColor"
        />
      </svg>
      <span class="inner-text"><%= @label %></span>
      <span class="while-submitting"><%= @in_progress_label %></span>
    </button>
    """
  end
end
