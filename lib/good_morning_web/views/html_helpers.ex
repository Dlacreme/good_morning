defmodule GMWeb.HTMLHelpers do
  use Phoenix.HTML

  def icon(name), do: content_tag(:i, name, class: "material-icons")
end
