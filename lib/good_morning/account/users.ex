defmodule GM.Account.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :joined_at, :naive_datetime
    field :left_at, :naive_datetime
    field :name, :string
    field :password, :string
    field :phone_number, :string
    field :picture_url, :string
    field :role_id, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:role_id, :name, :email, :password, :joined_at, :left_at, :title, :picture_url, :phone_number])
    |> validate_required([:role_id, :name, :email, :password, :joined_at, :left_at, :title, :picture_url, :phone_number])
  end
end
