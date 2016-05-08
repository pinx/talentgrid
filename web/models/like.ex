defmodule Talentgrid.Like do
  use Talentgrid.Web, :model

  schema "likes" do
    field :user_id, :string
    field :page_id, :string
    field :name, :string
    field :created_time, Ecto.DateTime
    field :text, :string

    timestamps
  end

  @required_fields ~w(user_id page_id)
  @optional_fields ~w(name created_time text)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:page_id, name: :likes_user_id_page_id_index)
  end
end
