defmodule GMWeb.HTMLHelpers do
  use Phoenix.HTML
  alias GM.Account.Users

  def icon(name, props \\ []),
    do: content_tag(:i, name, Keyword.merge(props, class: "material-icons"))

  def user_name(%Users{email: email, picture_url: picture_url, name: name}) do
    content_tag(
      :div,
      [
        content_tag(:img, "", src: picture_url),
        content_tag(
          :span,
          if name != "" && name != nil do
            name
          else
            email
          end
        )
      ],
      class: "flex flex-all-center"
    )
  end
end
