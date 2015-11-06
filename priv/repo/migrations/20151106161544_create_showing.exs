defmodule MovieStore.Repo.Migrations.CreateShowing do
  use Ecto.Migration

  def change do
    create table(:showings) do
      add :start_at, :datetime
      add :theater_id, references(:theaters)
      add :movie_id, references(:movies)

      timestamps
    end
    create index(:showings, [:theater_id])
    create index(:showings, [:movie_id])

  end
end
