defmodule MovieStore.Repo.Migrations.CreateTheater do
  use Ecto.Migration

  def change do
    create table(:theaters) do
      add :name, :string
      add :capacity, :integer

      timestamps
    end

  end
end
