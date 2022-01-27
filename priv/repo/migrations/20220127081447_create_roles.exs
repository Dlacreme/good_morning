defmodule GM.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :string, primary_key: true, size: 255
      add :label, :string
    end
  end
end
