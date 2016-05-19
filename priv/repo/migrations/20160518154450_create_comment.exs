defmodule Talentgrid.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :subject, :string
      add :subject_id, :string
      add :author, :string
      add :created_utc, :integer
    end

  end
end
