defmodule Paleta.Components.Preloader do
  use Paleta, :component

  def preloader(assigns) do
    ~H"""
    <div class="fixed z-50 grid w-full h-full app-preloader place-content-center bg-slate-50 dark:bg-navy-900">
      <div class="relative inline-block w-48 h-48 app-preloader-inner"></div>
    </div>
    """
  end
end
