defmodule GM.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  alias GM.Repo
  alias GM.Account.Roles

  def change do
    %Roles{
      id: "admin",
      label: "Admin"
    }
    |> Repo.insert!()

    %Roles{
      id: "user",
      label: "User"
    }
    |> Repo.insert!()

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :role_id, :string, size: 255, default: "user"
      add :name, :string, size: 255, null: true
      add :email, :string, size: 255, null: false
      add :password, :string
      add :joined_at, :naive_datetime, null: false
      add :left_at, :naive_datetime, null: true
      add :title, :string, size: 1024, null: true
      add :picture_url, :string, size: 1024, null: true
      add :phone_number, :string, size: 1024, null: true

      timestamps(updated_at: false)
    end
  end
end
