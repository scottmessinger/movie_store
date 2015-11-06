defmodule MovieStore.Showing do
  use MovieStore.Web, :model

  schema "showings" do
    field :start_at, Ecto.DateTime
    belongs_to :theater, MovieStore.Theater
    belongs_to :movie, MovieStore.Movie

    timestamps
  end

  @required_fields ~w(start_at)
  @optional_fields ~w(theater_id movie_id)

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
