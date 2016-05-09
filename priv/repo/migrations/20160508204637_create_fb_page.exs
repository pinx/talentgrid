defmodule Talentgrid.Repo.Migrations.CreateFbPage do
  use Ecto.Migration

  def change do
    create table(:fb_pages) do
      add :text, :text

      timestamps
    end

  end
end
