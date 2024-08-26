defmodule Paleta.Components.SidebarProfile do
  use Paleta, :component

  attr(:logout_path, :string, default: "/log-out")
  attr(:profile_path, :string, default: "/profile")
  attr(:user, :map, default: nil)

  def sidebar_profile(%{user: user} = assigns) do
    assigns = assigns |> assign(:full_name, full_name(user))

    ~H"""
    <!-- Profile -->
    <div
      :if={@user}
      x-data="usePopper({placement:'right-end',offset:12})"
      @click.outside="if(isShowPopper) isShowPopper = false"
      class="flex"
    >
      <button @click="isShowPopper = !isShowPopper" x-ref="popperRef" class="w-12 h-12 avatar">
        <img
          class="rounded-full"
          src={@user.avatar_url || "/images/default-user-avatar.jpg"}
          alt="avatar"
        />
        <span class="absolute right-0 h-3.5 w-3.5 rounded-full border-2 border-white bg-success dark:border-navy-700">
        </span>
      </button>

      <div x-bind:class="isShowPopper && 'show'" class="fixed popper-root" x-ref="popperRoot">
        <div class="w-64 bg-white border rounded-lg popper-box border-slate-150 shadow-soft dark:border-navy-600 dark:bg-navy-700">
          <div class="flex items-center px-4 py-5 space-x-4 rounded-t-lg bg-slate-100 dark:bg-navy-800">
            <div class="avatar h-14 w-14">
              <img
                class="rounded-full"
                src={@user.avatar_url || "/images/default-user-avatar.jpg"}
                alt="avatar"
              />
            </div>
            <div>
              <a
                href="#"
                class="text-base font-medium text-slate-700 hover:text-primary focus:text-primary dark:text-navy-100 dark:hover:text-accent-light dark:focus:text-accent-light"
              >
                <%= @full_name %>
              </a>
              <p class="text-xs break-all text-slate-400 dark:text-navy-300">
                <%= @user.email %>
              </p>
            </div>
          </div>
          <div class="flex flex-col pt-2 pb-5">
            <div class="px-4 mt-3">
              <.link
                href={@profile_path}
                class="flex items-center px-4 py-2 mb-2 space-x-3 tracking-wide transition-all rounded-md outline-none group hover:bg-slate-100 focus:bg-slate-100 dark:hover:bg-navy-600 dark:focus:bg-navy-600"
              >
                <div class="flex items-center justify-center w-8 h-8 text-white rounded-lg bg-warning">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-4.5 w-4.5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                    >
                    </path>
                  </svg>
                </div>

                <div>
                  <h2 class="font-medium transition-colors text-slate-700 group-hover:text-primary group-focus:text-primary dark:text-navy-100 dark:group-hover:text-accent-light dark:group-focus:text-accent-light">
                    Profile
                  </h2>
                  <div class="text-xs text-slate-400 line-clamp-1 dark:text-navy-300">
                    Your profile setting
                  </div>
                </div>
              </.link>

              <.link
                href={@logout_path}
                method="delete"
                class="w-full space-x-2 text-white btn h-9 bg-primary hover:bg-primary-focus focus:bg-primary-focus active:bg-primary-focus/90 dark:bg-accent dark:hover:bg-accent-focus dark:focus:bg-accent-focus dark:active:bg-accent/90"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="w-5 h-5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                  />
                </svg>
                <span>Logout</span>
              </.link>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def full_name(%{first_name: first_name, last_name: last_name}) do
    "#{first_name} #{last_name}"
  end

  def full_name(nil) do
    ""
  end
end
