defmodule Talentgrid.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :user_id, :bigint
      add :page_id, :bigint
      add :name, :string
      add :created_time, :datetime
      add :text, :text

      timestamps
    end

    create unique_index(:likes, [:user_id, :page_id])
  end
end
