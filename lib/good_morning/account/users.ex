defmodule GM.Account.Users do
  use Ecto.Schema
  import Ecto.Changeset
  alias GM.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :joined_at, :utc_datetime
    field :left_at, :utc_datetime
    field :name, :string
    field :password, :string
    field :phone_number, :string
    field :picture_url, :string
    field :bio, :string
    field :title, :string
    field :birthdate, :utc_datetime
    belongs_to :type, GM.Account.Types, type: :string

    timestamps(updated_at: false)
  end

  @doc false
  def changeset_register(users, attrs) do
    users
    |> cast(attrs, [
      :type_id,
      :name,
      :email,
      :password,
      :joined_at,
      :left_at,
      :title,
      :picture_url,
      :bio,
      :phone_number,
      :birthdate
    ])
    |> validate_required([:email, :password, :type_id])
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "invalid email")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 80)
    |> maybe_hash_password()
  end

  defp maybe_hash_password(changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        changeset
        |> put_change(:password, Bcrypt.hash_pwd_salt(password))
    end
  end
end
