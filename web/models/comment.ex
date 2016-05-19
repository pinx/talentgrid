defmodule Talentgrid.Comment do
  use Talentgrid.Web, :model

  schema "comments" do
    field :subject_id, :string
    field :author, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:subject_id, :author])
    |> validate_required([:subject_id, :author])
  end
end
