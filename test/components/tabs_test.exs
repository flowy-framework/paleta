defmodule Paleta.Components.TabsTest do
  use ExUnit.Case, async: true

  import Paleta.Components.Tabs
  import Paleta.Components.Card
  import Phoenix.Component, only: [sigil_H: 2]
  import Phoenix.LiveViewTest, only: [rendered_to_string: 1]

  setup(do: [assigns: []])

  describe "tabs/1" do
    test "tabs will be render properly", %{assigns: assigns} do
      h = ~H(<.tabs default="overview" id="product" class="w-[400px]">
  <:header target="overview" label="Overview" />
  <:header target="images" label="Images" />
  <:tab id="overview">
    <.card>
      Product
    </.card>
  </:tab>
  <:tab id="images">
    <.card>
      Images
    </.card>
  </:tab>
</.tabs>)
      assert rendered_to_string(h) =~ ~s(\n        Overview\n      <)
      assert rendered_to_string(h) =~ ~s(\n        Images\n      <)
      assert rendered_to_string(h) =~ ~s(>\n    \n    \n      Product\n    \n  </)
      assert rendered_to_string(h) =~ ~s(>\n    \n    \n      Images\n    \n  </)
    end
  end
end
