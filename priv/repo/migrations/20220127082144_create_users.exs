defmodule GM.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  alias GM.Repo
  alias GM.Account.Types

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    %Types{
      id: "admin",
      label: "Admin"
    }
    |> Repo.insert!()

    %Types{
      id: "user",
      label: "User"
    }
    |> Repo.insert!()

    %Types{
      id: "guest",
      label: "guest"
    }
    |> Repo.insert!()

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type_id, references(:types, type: :string), default: "user"
      add :name, :string, size: 255, null: true
      add :email, :citext, null: false
      add :password, :string
      add :joined_at, :utc_datetime, null: false
      add :left_at, :utc_datetime, null: true
      add :title, :string, size: 1024, null: true
      add :picture_url, :string, size: 1024, null: true
      add :phone_number, :string, size: 1024, null: true
      add :birthdate, :utc_datetime, null: true

      timestamps(updated_at: false)
    end

    create index(:users, [:id])
    create unique_index(:users, :email, name: :unique_index_user_email)
  end
end
