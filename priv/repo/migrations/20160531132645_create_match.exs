defmodule Talentgrid.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :source, :string, [primary_key: true]
      add :target, :string, [primary_key: true]
      add :score, :float

      timestamps
    end

  end
end
