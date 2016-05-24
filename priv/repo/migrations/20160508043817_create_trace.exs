defmodule Talentgrid.Repo.Migrations.CreateTrace do
  use Ecto.Migration

  def up do
    execute "CREATE TYPE source_enum AS ENUM ('facebook','twitter', 'google', 'reddit')"

    create table(:traces) do
      add :user_id, :bigint
      add :user_name, :string
      add :source, :source_enum
      add :subject_id, :string
      add :subject, :string
      add :created_at, :datetime
      add :text, :text
    end

  end

  def down do
    drop table(:traces)
    execute "DROP TYPE source_enum"
  end
end
