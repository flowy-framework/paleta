defmodule Paleta do
  @moduledoc """
  Design System for Elixir
  """

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
        Containers.OneColumnList,
        CopyToClipboard,
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
        Html
      }
    end
  end
end
