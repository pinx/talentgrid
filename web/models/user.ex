defmodule Talentgrid.User do
  use Talentgrid.Web, :model

  @primary_key {:id, :id, autogenerate: false}

  schema "users" do
    field :email, :string
    field :name, :string
    field :authentication_token, :string
    field :avatar, :string
    field :facebook_token, :string
    field :roles, :string
    field :current_sign_in_at, Ecto.DateTime
    field :last_sign_in_at, Ecto.DateTime
    field :current_sign_in_ip, :string
    field :last_sign_in_ip, :string

    timestamps
  end

  @required_fields ~w(name id )
  @optional_fields ~w(email facebook_token avatar roles authentication_token )

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
