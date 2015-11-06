defmodule MovieStore.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :quantity, :integer
      add :showing_id, references(:showings)

      timestamps
    end
    create index(:tickets, [:showing_id])

  end
end
