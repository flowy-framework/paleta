defmodule Paleta.Components.FieldHelper do
  import Phoenix.Component

  def assign_basic_attrs(%{field: nil} = assigns) do
    with %{value: %Phoenix.HTML.FormField{} = field} <- assigns do
      assigns
      |> assign(:id, field.id)
      |> assign(:name, field.name)
      |> assign(:value, parse_value(field.value))
      |> assign(:errors, field.errors)
    end
  end

  def assign_basic_attrs(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(:id, field.id)
    |> assign(:name, field.name)
    |> assign(:value, parse_value(field.value))
    |> assign(:errors, field.errors)
  end

  # This is mainly used for the advance select component,
  # but it can be used for other components as well. We basically
  # can't have atoms as values
  defp parse_value(value) when is_atom(value), do: Atom.to_string(value)

  defp parse_value(values) when is_list(values) do
    values
    |> Enum.map(&parse_value(&1))
  end

  defp parse_value(value), do: value
end
