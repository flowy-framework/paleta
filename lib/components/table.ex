defmodule Paleta.Components.Table do
  use Phoenix.Component
  alias Paleta.Components.Card
  alias Phoenix.LiveView.JS

  attr(:id, :string, default: "p-table")
  attr(:rows, :list, doc: "Data you want to list", required: true)
  attr(:row_id, :any, default: nil, doc: "the function for generating the row id")
  attr(:search, :boolean, doc: "Show or hide search bar", default: false)
  attr(:pagination, :map, doc: "Show or hide pagination", default: nil)
  attr(:row_click, :any, default: nil, doc: "the function for handling phx-click on each row")

  slot :col, doc: "Describe one of your table columns" do
    attr(:label, :string, doc: "Column label", required: true)
    attr(:position, :string, doc: "Column position: :left or :center")
  end

  slot(:adv_search, doc: "Describe advance inputs")
  slot(:actions, doc: "Describe one of your table columns")

  def table(%{actions: actions, pagination: pagination} = assigns) do
    {first_column, cols} = assigns[:col] |> List.pop_at(0)

    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end

    assigns =
      assigns
      |> assign(:first_column, first_column)
      |> assign(:show_actions, length(actions) > 0)
      |> assign(:col, cols)
      |> assign(:pages, build_pages(pagination))

    ~H"""
    <div class="grid grid-cols-1 gap-4 sm:gap-5 lg:gap-6">
      <div x-data="{isFilterExpanded:false}">
        <div class="flex items-center justify-between">
          <h2 class="text-base font-medium tracking-wide text-slate-700 line-clamp-1 dark:text-navy-100">
          </h2>
          <div :if={@search} class="flex">
            <div class="flex items-center" x-data="{isInputActive:false}">
              <label class="block">
                <!-- TODO: We need to see if we can use phoenix JS here -->
                <input
                  phx-keyup="search"
                  phx-debounce="500"
                  x-effect="isInputActive === true && $nextTick(() => { $el.focus()});"
                  x-bind:class="isInputActive ? 'w-32 lg:w-48' : 'w-0'"
                  class="form-input bg-transparent px-1 text-right transition-all duration-100 placeholder:text-slate-500 dark:placeholder:text-navy-200"
                  placeholder="Search here..."
                  type="text"
                />
              </label>
              <!-- TODO: We need to see if we can use phoenix JS here -->
              <button
                @click="isInputActive = !isInputActive"
                class="btn h-8 w-8 rounded-full p-0 hover:bg-slate-300/20 focus:bg-slate-300/20 active:bg-slate-300/25 dark:hover:bg-navy-300/20 dark:focus:bg-navy-300/20 dark:active:bg-navy-300/25"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4.5 w-4.5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="1.5"
                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                  />
                </svg>
              </button>
            </div>
            <button
              :if={@adv_search}
              phx-click={JS.toggle(to: "#adv-search", in: "fade-in-scale", out: "fade-out-scale")}
              class="btn h-8 w-8 rounded-full p-0 hover:bg-slate-300/20 focus:bg-slate-300/20 active:bg-slate-300/25 dark:hover:bg-navy-300/20 dark:focus:bg-navy-300/20 dark:active:bg-navy-300/25"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-4.5 w-4.5"
                fill="none"
                viewBox="0 0 24 24"
              >
                <path
                  stroke="currentColor"
                  stroke-linecap="round"
                  stroke-width="2"
                  d="M18 11.5H6M21 4H3m6 15h6"
                >
                </path>
              </svg>
            </button>
          </div>
        </div>
        <div id="adv-search" phx-update="ignore" hidden style="height: auto;">
          <Card.card title="Adv Search">
            <.form :let={f} for={%{}} as={:adv_filter} phx-submit="adv-search" role="form text-left">
              <div class="max-w-2xl py-3">
                <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-5 lg:gap-6">
                  <%= render_slot(@adv_search, f) %>
                </div>
                <div class="mt-4 space-x-1 text-right">
                  <button
                    type="button"
                    phx-click={
                      JS.toggle(to: "#adv-search", in: "fade-in-scale", out: "fade-out-scale")
                    }
                    class="btn font-medium text-slate-700 hover:bg-slate-300/20 active:bg-slate-300/25 dark:text-navy-100 dark:hover:bg-navy-300/20 dark:active:bg-navy-300/25"
                  >
                    Cancel
                  </button>

                  <button
                    @click="isFilterExpanded = ! isFilterExpanded"
                    class="btn bg-primary font-medium text-white hover:bg-primary-focus focus:bg-primary-focus active:bg-primary-focus/90 dark:bg-accent dark:hover:bg-accent-focus dark:focus:bg-accent-focus dark:active:bg-accent/90"
                  >
                    Apply
                  </button>
                </div>
              </div>
            </.form>
          </Card.card>
        </div>
        <div class="card mt-3">
          <div class="is-scrollbar-hidden min-w-full overflow-x-auto">
            <table class="is-hoverable w-full text-left">
              <thead>
                <tr class="border-y border-transparent border-b-slate-200 dark:border-b-navy-500">
                  <th class="whitespace-nowrap px-3 py-3 font-semibold uppercase text-slate-800 dark:text-navy-100 lg:px-5">
                    <%= @first_column.label %>
                  </th>
                  <th
                    :for={col <- @col}
                    class="whitespace-nowrap px-3 py-3 font-semibold uppercase text-slate-800 dark:text-navy-100 lg:px-5"
                  >
                    <%= col.label %>
                  </th>
                  <th
                    :if={@show_actions}
                    class="whitespace-nowrap px-3 py-3 font-semibold uppercase text-slate-800 dark:text-navy-100 lg:px-5"
                  >
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody id={@id} phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"}>
                <tr
                  :for={row <- @rows}
                  id={@row_id && @row_id.(row)}
                  phx-click={@row_click && @row_click.(row)}
                  class={[
                    "border-y border-transparent border-b-slate-200 dark:border-b-navy-500",
                    @row_click && "hover:cursor-pointer"
                  ]}
                >
                  <td class="whitespace-nowrap px-4 py-3 sm:px-5">
                    <%= render_slot(@first_column, row) %>
                  </td>
                  <td :for={col <- @col} class="whitespace-nowrap px-4 py-3 sm:px-5">
                    <%= render_slot(col, row) %>
                  </td>

                  <td :if={@actions} class="whitespace-nowrap px-4 py-3 sm:px-5">
                    <div class="inline-flex">
                      <%= render_slot(@actions, row) %>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div
            :if={@pagination}
            class="flex flex-col justify-between space-y-4 px-4 py-4 sm:flex-row sm:items-center sm:space-y-0 sm:px-5"
          >
            <div class="flex items-center space-x-2 text-xs+">
              <span>Show</span>
              <label class="block">
                <select
                  disabled
                  class="form-select rounded-full border border-slate-300 bg-white px-2 py-1 pr-6 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:bg-navy-700 dark:hover:border-navy-400 dark:focus:border-accent"
                >
                  <option>10</option>
                  <option selected>20</option>
                  <option>50</option>
                </select>
              </label>
              <span>entries</span>
            </div>

            <ol class="pagination">
              <li class="rounded-l-lg bg-slate-150 dark:bg-navy-500">
                <button
                  phx-click="paginate"
                  phx-value-page={prev_page(@pagination)}
                  href="#"
                  disabled={disable_prev_page(@pagination)}
                  class="flex h-8 w-8 items-center justify-center rounded-lg text-slate-500 transition-colors hover:bg-slate-300 focus:bg-slate-300 active:bg-slate-300/80 dark:text-navy-200 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-4 w-4"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    stroke-width="2"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
              </li>

              <li :for={page <- @pages} class="bg-slate-150 dark:bg-navy-500">
                <a href="#" class={page_class(page)} phx-click="paginate" phx-value-page={page[:page]}>
                  <%= page[:label] %>
                </a>
              </li>
              <li class="rounded-r-lg bg-slate-150 dark:bg-navy-500">
                <button
                  phx-click="paginate"
                  phx-value-page={next_page(@pagination)}
                  disabled={disable_next_page(@pagination)}
                  class="flex h-8 w-8 items-center justify-center rounded-lg text-slate-500 transition-colors hover:bg-slate-300 focus:bg-slate-300 active:bg-slate-300/80 dark:text-navy-200 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-4 w-4"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M9 5l7 7-7 7"
                    />
                  </svg>
                </button>
              </li>
            </ol>

            <div class="text-xs+">
              <%= @pagination.current_page * @pagination.per_page + 1 %> - <%= current_page(
                @pagination.current_page
              ) *
                @pagination.per_page %> of <%= @pagination.total %> entries
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp disable_next_page(%{current_page: current_page, pages: pages})
       when current_page == pages - 1,
       do: true

  defp disable_next_page(_), do: false

  defp disable_prev_page(%{current_page: 0}), do: true
  defp disable_prev_page(_), do: false

  defp next_page(%{current_page: current_page, pages: pages}) when current_page < pages,
    do: current_page + 1

  defp next_page(%{current_page: current_page}), do: current_page

  defp prev_page(%{current_page: 0}), do: 0

  defp prev_page(%{current_page: current_page}) when current_page > 0,
    do: current_page - 1

  defp current_page(page), do: page + 1

  defp build_pages(nil), do: nil

  defp build_pages(pagination) do
    pagination
    |> Paleta.Components.Table.Pagination.pagination()
  end

  defp page_class(%{active: false}),
    do:
      "flex h-8 min-w-[2rem] items-center justify-center rounded-lg px-3 leading-tight transition-colors hover:bg-slate-300 focus:bg-slate-300 active:bg-slate-300/80 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"

  defp page_class(%{active: true}),
    do:
      "flex h-8 min-w-[2rem] items-center justify-center rounded-lg bg-primary px-3 leading-tight text-white transition-colors hover:bg-primary-focus focus:bg-primary-focus active:bg-primary-focus/90 dark:bg-accent dark:hover:bg-accent-focus dark:focus:bg-accent-focus dark:active:bg-accent/90"
end
