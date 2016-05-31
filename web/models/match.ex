defmodule Talentgrid.Match do
  use Talentgrid.Web, :model

  @primary_key false
  schema "matches" do
    field :source, :string, primary_key: true
    field :target, :string, primary_key: true
    field :score, :float

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:source, :target, :score])
    |> validate_required([:source, :target, :score])
  end
end
