defmodule Talentgrid.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :subject_id, :string
      add :author, :string

      timestamps
    end

  end
end
