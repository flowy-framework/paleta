defmodule Paleta.Utils.DateHelper do
  use Timex

  def current_minutes() do
    {:ok, formated_date} =
      DateTime.utc_now()
      |> Timex.format("{h24}:{m} {Zabbr}")

    formated_date
  end

  def from_now(date) when is_binary(date) do
    date
    |> parse_date()
    |> from_now()
  end

  def from_now(date), do: Timex.from_now(date, "en")

  def from_now(date, :short) do
    str_date = Timex.from_now(date, "en")

    # TODO: This is ugly as hell
    cond do
      String.contains?(str_date, "second ago") -> String.replace(str_date, " second ago", "s")
      String.contains?(str_date, "seconds ago") -> String.replace(str_date, " seconds ago", "s")
      String.contains?(str_date, "minute ago") -> String.replace(str_date, " minute ago", "m")
      String.contains?(str_date, "minutes ago") -> String.replace(str_date, " minutes ago", "m")
      String.contains?(str_date, "hour ago") -> String.replace(str_date, " hour ago", "h")
      String.contains?(str_date, "hours ago") -> String.replace(str_date, " hours ago", "h")
      String.contains?(str_date, "day ago") -> String.replace(str_date, " day ago", "d")
      String.contains?(str_date, "days ago") -> String.replace(str_date, " days ago", "d")
      String.contains?(str_date, "month ago") -> String.replace(str_date, " month ago", "mo")
      String.contains?(str_date, "months ago") -> String.replace(str_date, " months ago", "mo")
      String.contains?(str_date, "year ago") -> String.replace(str_date, " year ago", "mo")
      String.contains?(str_date, "years ago") -> String.replace(str_date, " years ago", "mo")
      true -> str_date
    end
  end

  def from_now(), do: Timex.from_now(DateTime.utc_now())

  def from_unix(value, unit) do
    Timex.from_unix(value, unit)
  end

  def today_to_unix() do
    DateTime.utc_now() |> DateTime.to_unix()
  end

  def to_unix(date) do
    date |> DateTime.to_unix()
  end

  def parse_date(date) when is_binary(date) do
    {:ok, parsed_date} = Timex.parse(date, "{ISO:Extended:Z}")
    parsed_date
  end

  def parse_date(date) do
    date
  end

  def diff_in_days(start_date, end_date \\ NaiveDateTime.local_now())

  def diff_in_days(start_date, end_date)
      when is_binary(start_date) and is_binary(end_date) do
    parsed_start_date = parse_date(start_date)
    parsed_end_date = parse_date(end_date)

    Timex.diff(parsed_end_date, parsed_start_date, :days)
  end

  def diff_in_days(start_date, end_date) do
    Timex.diff(end_date, start_date, :days)
  end

  def today() do
    Timex.today()
  end

  def now() do
    Timex.now()
  end

  def today_as_string() do
    Timex.today()
    |> Timex.format!("%FT%T%:z", :strftime)
  end

  def now_as_string() do
    Timex.now()
    |> Timex.format!("%FT%T%:z", :strftime)
  end

  def date_without_year(date) when is_binary(date) do
    {:ok, value} =
      date
      |> parse_date()
      |> Timex.format("{M}/{D}")

    value
  end

  def date_without_year(date) do
    {:ok, value} =
      date
      |> Timex.format("{M}/{D}")

    value
  end

  # create a function that receive a date and the number of hours to substract and return a new date using Timex
  def substract_hours(date, hours) do
    Timex.shift(date, hours: -hours)
  end

  def to_string(date) do
    Timex.format!(date, "{ISO:Extended:Z}")
  end

  def format_date(date, format \\ :long)
  def format_date(nil, _format), do: nil

  @long_date_format "{WDshort}, {Mshort} {D}, {YYYY} {h24}:{m}:{s}"
  @short_date_format "{WDshort}, {Mshort} {D}, {YYYY}"

  def format_date(date, :long) when is_binary(date) do
    Timex.parse!(date, "{ISO:Extended:Z}")
    |> Timex.format!(@long_date_format)
  end

  def format_date(date, :short) when is_binary(date) do
    Timex.parse!(date, "{ISO:Extended:Z}")
    |> Timex.format!(@short_date_format)
  end

  def format_date(date, :long) do
    date
    |> Timex.format!(@long_date_format)
  end

  def format_date(date, :short) do
    date
    |> Timex.format!(@short_date_format)
  end
end
