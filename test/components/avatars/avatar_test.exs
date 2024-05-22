defmodule Paleta.Components.AvatarTest do
  use ExUnit.Case, async: true

  import Paleta.Components.Avatars.Avatar
  import Phoenix.Component, only: [sigil_H: 2]
  import Phoenix.LiveViewTest, only: [rendered_to_string: 1]

  setup(do: [assigns: %{}])

  describe "avatar/1" do
    @describetag :avatar
    test "avatar will be rendered properly with default type", %{assigns: assigns} do
      h = ~H(<.avatar src="/img/avatar.jpg" />)

      assert rendered_to_string(h) ==
               "<div class=\"avatar size-8 \">\n  <img class=\"rounded-full\" src=\"/img/avatar.jpg\" alt=\"avatar\">\n</div>"
    end

    test "avatar will be rendered properly with square type", %{assigns: assigns} do
      h = ~H(<.avatar type={:square} src="/img/avatar.jpg" />)

      assert rendered_to_string(h) ==
               "<div class=\"avatar size-8 \">\n  <img class=\"rounded-lg\" src=\"/img/avatar.jpg\" alt=\"avatar\">\n</div>"
    end

    test "avatar will be rendered properly with squircle type", %{assigns: assigns} do
      h = ~H(<.avatar type={:squircle} src="/img/avatar.jpg" size="10" />)

      assert rendered_to_string(h) ==
               "<div class=\"avatar size-10 \">\n  <img class=\"mask is-squircle\" src=\"/img/avatar.jpg\" alt=\"avatar\">\n</div>"
    end
  end
end
