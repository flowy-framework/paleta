defmodule Paleta.Components.SpanTest do
  use ExUnit.Case, async: true

  import Paleta.Components.Span
  import Phoenix.Component, only: [sigil_H: 2]
  import Phoenix.LiveViewTest, only: [rendered_to_string: 1]

  describe "span/1" do
    @describetag :span
    test "with valid value" do
      assigns = %{value: "Hola"}
      h = ~H(<.span value={@value} />)
      assert rendered_to_string(h) =~ ~s(<span>Hola</span>)
    end

    test "with invalid value" do
      assigns = %{value: nil}
      h = ~H(<.span value={@value} />)
      assert rendered_to_string(h) =~ ~s(<span></span>)
    end

    test "with valid long value" do
      assigns = %{value: "this is a test"}
      h = ~H(<.span value={@value} max_length={10} />)
      assert rendered_to_string(h) =~ ~s(<span>this is...</span>)
    end
  end
end
