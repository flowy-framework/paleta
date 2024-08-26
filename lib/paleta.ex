defmodule Paleta do
  @moduledoc """
  Design System for Elixir
  """

  def component do
    quote do
      use Phoenix.Component, global_prefixes: ~w(x-)

      alias Phoenix.LiveView.JS
    end
  end

  @doc """
  When used, dispatch to the appropriate macro.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(_) do
    quote do
      import Paleta.Components.{
        ActionLink,
        ActionButton,
        AdvanceSelect,
        Alert,
        AppHeader,
        AppHeaderWrapper,
        Avatars.Avatar,
        Avatars.InitialAvatar,
        Badges.Badge,
        Badges.GlowBadge,
        Badges.RoundedBadge,
        Body,
        Breadcrumb,
        Button,
        Card,
        CardWithSideMenu,
        Containers.OneColumnList,
        CopyToClipboard,
        Div,
        Favorite,
        Editor,
        Error,
        ErrorPage,
        Field,
        Flash,
        Form,
        FromNow,
        Head,
        Icon,
        Input,
        Label,
        Link,
        List,
        Loading,
        MainContentWrapper,
        SignIn,
        Modal,
        PageHeader,
        Pagination,
        PageWrapper,
        Preloader,
        Progress,
        Radio,
        Restrict,
        Checkbox,
        Select,
        ShortId,
        SidebarComponent,
        Sidebar.Group,
        Sidebar.Item,
        Sidebar.Main,
        Sidebar.MainItem,
        Sidebar.Panel,
        SideNav,
        Span,
        Spinner,
        SyntaxHighlighter,
        Switch,
        Table,
        Tabs,
        Html
      }
    end
  end
end
