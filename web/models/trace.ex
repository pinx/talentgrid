defmodule Talentgrid.Trace do
  use Talentgrid.Web, :model
  import Talentgrid.Enum

  defenum SourceEnum, "source_enum", ~w"facebook twitter google reddit"

  schema "traces" do
    field :user_id, :integer
    field :user_name, :string
    field :source, :string
    field :subject_id, :string
    field :subject, :string
    field :created_at, Ecto.DateTime
    field :text, :string
  end

  @required_fields ~w(subject_id source)
  @optional_fields ~w(user_id user_name subject created_at text)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    # |> unique_constraint(:subject_id, name: :traces_user_id_subject_id_index)
  end
end
