defmodule Talentgrid.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :authentication_token, :string
      add :facebook_uid, :string
      add :avatar, :string
      add :facebook_token, :string
      add :current_sign_in_at, :datetime
      add :last_sign_in_at, :datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string

      timestamps
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:facebook_uid])
  end
end
