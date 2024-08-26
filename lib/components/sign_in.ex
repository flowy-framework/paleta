defmodule Paleta.Components.SignIn do
  use Paleta, :component

  attr(:title, :string, required: true)
  attr(:error, :string, default: nil)
  attr(:oauth_path, :string, required: true)
  attr(:footer, :boolean, default: true)
  attr(:logo, :string, default: "/images/logo-300.png")
  attr(:logo_css, :string, default: "mx-auto h-16 w-24")

  def sign_in(assigns) do
    ~H"""
    <main class="grid w-full grid-cols-1 grow place-items-center">
      <div class="w-full max-w-[26rem] p-4 sm:px-5">
        <div class="text-center">
          <img class={@logo_css} src={@logo} alt="logo" />
          <div class="mt-4">
            <h2 class="text-2xl font-semibold text-slate-600 dark:text-navy-100">
              <%= @title %>
            </h2>
            <p class="text-slate-400 dark:text-navy-300">
              Please sign in to continue
            </p>
            <p :if={@error} class="alert alert-danger" role="alert"><%= @error %></p>
          </div>
        </div>
        <div class="p-5 mt-5 rounded-lg card lg:p-7">
          <.link
            href={@oauth_path}
            class="w-full mt-5 font-medium text-white btn bg-primary hover:bg-primary-focus focus:bg-primary-focus active:bg-primary-focus/90 dark:bg-accent dark:hover:bg-accent-focus dark:focus:bg-accent-focus dark:active:bg-accent/90"
          >
            Sign In
          </.link>
          <div :if={@footer} class="mt-4 text-center text-xs+">
            <p class="line-clamp-1">
              <span>Looking for other app?</span>

              <a
                target="_blank"
                class="transition-colors text-primary hover:text-primary-focus dark:text-accent-light dark:hover:text-accent"
                href={Paleta.Config.catalog_url()}
              >
                Explore the catalog
              </a>
            </p>
          </div>
        </div>
      </div>
    </main>
    """
  end
end
