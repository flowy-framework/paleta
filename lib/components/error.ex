defmodule Paleta.Components.Error do
  use Paleta, :component

  @doc """
  Generates a generic error message.
  """
  slot(:inner_block, required: true)

  def error(assigns) do
    ~H"""
    <p class="flex gap-3 mt-3 text-sm leading-6 text-rose-600 phx-no-feedback:hidden">
      <Paleta.Components.Icon.icon
        name="hero-exclamation-circle-mini"
        class="mt-0.5 h-5 w-5 flex-none"
      />
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:errors, :list, required: true)

  def errors(%{errors: errors} = assigns) do
    assigns =
      assigns
      |> assign(:parsed_errors, Enum.map(errors, &translate_error(&1)))

    ~H"""
    <.error :for={error <- @parsed_errors}>
      <%= error %>
    </.error>
    """
  end

  defp translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(Paleta.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(Paleta.Gettext, "errors", msg, opts)
    end
  end
end
