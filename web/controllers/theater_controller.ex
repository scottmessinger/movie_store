defmodule MovieStore.TheaterController do
  use MovieStore.Web, :controller

  alias MovieStore.Theater

  plug :scrub_params, "theater" when action in [:create, :update]

  def index(conn, _params) do
    theaters = Repo.all(Theater)
    render(conn, "index.html", theaters: theaters)
  end

  def new(conn, _params) do
    changeset = Theater.changeset(%Theater{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"theater" => theater_params}) do
    changeset = Theater.changeset(%Theater{}, theater_params)

    case Repo.insert(changeset) do
      {:ok, _theater} ->
        conn
        |> put_flash(:info, "Theater created successfully.")
        |> redirect(to: theater_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    theater = Repo.get!(Theater, id)
    render(conn, "show.html", theater: theater)
  end

  def edit(conn, %{"id" => id}) do
    theater = Repo.get!(Theater, id)
    changeset = Theater.changeset(theater)
    render(conn, "edit.html", theater: theater, changeset: changeset)
  end

  def update(conn, %{"id" => id, "theater" => theater_params}) do
    theater = Repo.get!(Theater, id)
    changeset = Theater.changeset(theater, theater_params)

    case Repo.update(changeset) do
      {:ok, theater} ->
        conn
        |> put_flash(:info, "Theater updated successfully.")
        |> redirect(to: theater_path(conn, :show, theater))
      {:error, changeset} ->
        render(conn, "edit.html", theater: theater, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    theater = Repo.get!(Theater, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(theater)

    conn
    |> put_flash(:info, "Theater deleted successfully.")
    |> redirect(to: theater_path(conn, :index))
  end
end
