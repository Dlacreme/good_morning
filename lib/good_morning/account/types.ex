defmodule GM.Account.Types do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "types" do
    field :label, :string
  end
end
