defmodule GM.Account.Tokens do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tokens" do
    field :deprecated_at, :utc_datetime
    field :token, :string
    belongs_to :user, GM.Account.Users
    belongs_to :type, GM.Account.TokenTypes, type: :string

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(tokens, attrs) do
    tokens
    |> cast(attrs, [:token, :deprecated_at, :user_id, :type_id])
    |> validate_required([:token, :deprecated_at, :user_id, :type_id])
  end
end
