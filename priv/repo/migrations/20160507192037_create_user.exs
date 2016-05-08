defmodule Talentgrid.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :email, :string
      add :name, :string
      add :authentication_token, :string, size: 512
      add :avatar, :string
      add :facebook_token, :string, size: 512
      add :roles, :string, default: "seeker"
      add :current_sign_in_at, :datetime
      add :last_sign_in_at, :datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string

      timestamps
    end

    create unique_index(:users, [:email])
  end
end
