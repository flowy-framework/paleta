defmodule Paleta.Components.Dummy do
  use Phoenix.Component

  @moduledoc """
  Dummy component for generating tailwind css classes
  For some reason that I couldn't figure out, the tailwind classes are not being generated
  when the component is not being used in the project
  """

  def dummy(assigns) do
    ~H"""
    <div class="h-32 no-underline size-10 size-16 size-20 size-28">
      <!-- This is a dummy component to generate tailwind css classes for fonts -->
      <span class="text-tiny text-tiny+ text-xs+ text-sm+"></span>
    </div>
    """
  end
end
