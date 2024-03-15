defmodule Paleta.Components.Table.Pagination do
  defstruct [:current_page, :pages, :per_page, :total, :zero_based]

  def build(%{
        current_page: current_page,
        total_pages: total_pages,
        page_size: page_size,
        total_count: total_count
      }) do
    %__MODULE__{
      current_page: current_page,
      pages: total_pages,
      per_page: page_size,
      total: total_count,
      zero_based: false
    }
  end

  def build(attrs) do
    struct(__MODULE__, attrs)
  end

  # Adding support for Flop pagination

  def pagination(%{current_page: current_page, pages: pages} = params) do
    zero_based = Map.get(params, :zero_based, true)
    start_index = if zero_based, do: 0, else: 1
    end_index = if zero_based, do: pages - 1, else: pages

    case pages do
      pages when pages <= 5 ->
        Enum.map(start_index..end_index, fn page ->
          %{page: page, active: page == current_page, label: page_label(page, zero_based)}
        end)

      _ ->
        pages_list =
          if current_page <= 5 do
            Enum.concat(
              1..(current_page + 1),
              if current_page + 1 < pages do
                ["..."]
              else
                []
              end
            )
          else
            list =
              Enum.concat(
                (current_page - 3)..(current_page + 1),
                if current_page + 1 < pages do
                  ["..."]
                else
                  []
                end
              )

            Enum.concat(["..."], list)
          end

        first_elem = if zero_based, do: [0], else: []
        pages_list_with_first_and_last = Enum.concat([first_elem, pages_list, [end_index]])

        Enum.map(pages_list_with_first_and_last, fn page ->
          %{page: page, active: page == current_page, label: page_label(page, zero_based)}
        end)
    end
  end

  def page_label(page, true) when is_integer(page), do: Integer.to_string(page + 1)
  def page_label(page, false) when is_integer(page), do: Integer.to_string(page)
  def page_label("...", _), do: "..."
end
