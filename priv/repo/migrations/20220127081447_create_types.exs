defmodule GM.Repo.Migrations.CreateTypes do
  use Ecto.Migration

  def change do
    create table(:types, primary_key: false) do
      add :id, :string, primary_key: true, size: 255
      add :label, :string
    end
  end
end
