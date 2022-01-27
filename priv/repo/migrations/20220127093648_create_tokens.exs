defmodule GM.Repo.Migrations.CreateTokens do
  use Ecto.Migration
  alias GM.Repo
  alias GM.Account.TokenTypes

  def change do
    Repo.insert(%TokenTypes{
      id: "authorization",
      label: "Authorization"
    })

    Repo.insert(%TokenTypes{
      id: "password_recovery",
      label: "Password Recovery"
    })

    Repo.insert(%TokenTypes{
      id: "account_validation",
      label: "Account Validation"
    })

    create table(:tokens, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :token, :string, length: 550, null: false
      add :deprecated_at, :utc_datetime, null: false
      add :type_id, references(:token_types, type: :string), null: false
      add :user_id, references(:users, type: :binary_id), null: false

      timestamps(updated_at: false)
    end
  end
end
