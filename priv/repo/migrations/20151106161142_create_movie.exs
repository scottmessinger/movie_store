defmodule MovieStore.Repo.Migrations.CreateMovie do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :name, :string

      timestamps
    end

  end
end
