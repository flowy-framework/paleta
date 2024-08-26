defmodule Paleta.Components.Pagination do
  use Paleta, :component

  attr(:pagination, :map, doc: "Show or hide pagination", default: nil)
  attr(:show_per_page, :boolean, default: false)
  attr(:target, :any)

  def pagination(%{pagination: pagination} = assigns) do
    assigns =
      assigns
      |> assign(:pages, build_pages(pagination))

    ~H"""
    <div class="flex flex-col justify-between px-4 py-4 space-y-4 sm:flex-row sm:items-center sm:space-y-0 sm:px-5">
      <div :if={@show_per_page} class="flex items-center space-x-2 text-xs+">
        <span>Show</span>
        <label class="block">
          <select
            disabled
            class="px-2 py-1 pr-6 bg-white border rounded-full form-select border-slate-300 hover:border-slate-400 focus:border-primary dark:border-navy-450 dark:bg-navy-700 dark:hover:border-navy-400 dark:focus:border-accent"
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
            phx-target={@target}
            phx-click="paginate"
            phx-value-page={prev_page(@pagination)}
            href="#"
            disabled={disable_prev_page(@pagination)}
            class="flex items-center justify-center w-8 h-8 transition-colors rounded-lg text-slate-500 hover:bg-slate-300 focus:bg-slate-300 active:bg-slate-300/80 dark:text-navy-200 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="w-4 h-4"
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
          <a
            href="#"
            class={page_class(page)}
            phx-target={@target}
            phx-click="paginate"
            phx-value-page={page[:page]}
          >
            <%= page[:label] %>
          </a>
        </li>
        <li class="rounded-r-lg bg-slate-150 dark:bg-navy-500">
          <button
            phx-target={@target}
            phx-click="paginate"
            phx-value-page={next_page(@pagination)}
            disabled={disable_next_page(@pagination)}
            class="flex items-center justify-center w-8 h-8 transition-colors rounded-lg text-slate-500 hover:bg-slate-300 focus:bg-slate-300 active:bg-slate-300/80 dark:text-navy-200 dark:hover:bg-navy-450 dark:focus:bg-navy-450 dark:active:bg-navy-450/90"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="w-4 h-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </li>
      </ol>

      <div class="text-xs+">
        <%= entries_from(@pagination) %> - <%= entries_to(@pagination) %> of <%= @pagination.total %> entries
      </div>
    </div>
    """
  end

  defp disable_next_page(%{zero_based: false, current_page: current_page, pages: pages})
       when current_page == pages,
       do: true

  defp disable_next_page(%{zero_based: true, current_page: current_page, pages: pages})
       when current_page == pages - 1,
       do: true

  defp disable_next_page(_), do: false

  defp disable_prev_page(%{zero_based: false, current_page: 1}), do: true
  defp disable_prev_page(%{zero_based: true, current_page: 0}), do: true
  defp disable_prev_page(%{current_page: 0}), do: true
  defp disable_prev_page(_), do: false

  defp next_page(%{current_page: current_page, pages: pages}) when current_page < pages,
    do: current_page + 1

  defp next_page(%{current_page: current_page}), do: current_page

  defp prev_page(%{current_page: 0}), do: 0

  defp prev_page(%{current_page: current_page}) when current_page > 0,
    do: current_page - 1

  defp entries_from(%{zero_based: false, current_page: 1}), do: 1
  defp entries_from(%{zero_based: true, current_page: 0}), do: 1

  defp entries_from(%{zero_based: true, current_page: current_page, per_page: per_page}) do
    current_page * per_page + 1
  end

  defp entries_from(%{zero_based: false, current_page: current_page, per_page: per_page}) do
    (current_page - 1) * per_page + 1
  end

  defp entries_to(%{zero_based: true, current_page: current_page, per_page: per_page}) do
    (current_page + 1) * per_page
  end

  defp entries_to(%{
         zero_based: false,
         current_page: current_page,
         per_page: per_page,
         total: total
       }) do
    calculated_total = current_page * per_page

    if total < calculated_total do
      total
    else
      calculated_total
    end
  end

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
