defmodule Paleta.Components.BreadcrumbTest do
  use ExUnit.Case, async: true

  import Paleta.Components.Breadcrumb
  import Phoenix.Component, only: [sigil_H: 2]
  import Phoenix.LiveViewTest, only: [rendered_to_string: 1]

  alias Paleta.Components.Breadcrumb.Step

  setup(
    do: [assigns: %{title: "Testing", steps: [%Step{label: "Home"}, %Step{label: "Another"}]}]
  )

  describe "breadcrumb/1" do
    test "breadcrumb will be render properly", %{assigns: assigns} do
      h = ~H(<.breadcrumb title={@title} steps={@steps} />)
      assert rendered_to_string(h) =~ ~s(>Another<)
    end
  end
end
