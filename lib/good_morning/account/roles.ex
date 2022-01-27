defmodule GM.Account.Roles do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "roles" do
    field :label, :string
  end
end
