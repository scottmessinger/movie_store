defmodule MovieStore.ShowingController do
  use MovieStore.Web, :controller

  alias MovieStore.Showing

  plug :scrub_params, "showing" when action in [:create, :update]

  def index(conn, _params) do
    showings = Repo.all(Showing) |> Repo.preload(:theater) |> Repo.preload(:movie)
    render(conn, "index.html", showings: showings)
  end

  def new(conn, _params) do
    changeset = Showing.changeset(%Showing{})
    render(conn, "new.html", changeset: changeset, theaters: theater_dropdowns, movies: movie_dropdowns)
  end

  def create(conn, %{"showing" => showing_params}) do
    changeset = Showing.changeset(%Showing{}, showing_params)

    case Repo.insert(changeset) do
      {:ok, _showing} ->
        conn
        |> put_flash(:info, "Showing created successfully.")
        |> redirect(to: showing_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    showing = Repo.get!(Showing, id) |> Repo.preload(:theater) |> Repo.preload(:movie)
    render(conn, "show.html", showing: showing)
  end

  def edit(conn, %{"id" => id}) do
    showing = Repo.get!(Showing, id)
    changeset = Showing.changeset(showing)
    render(conn, "edit.html", showing: showing, changeset: changeset, theaters: theater_dropdowns, movies: movie_dropdowns)
  end

  def update(conn, %{"id" => id, "showing" => showing_params}) do
    showing = Repo.get!(Showing, id)
    changeset = Showing.changeset(showing, showing_params)

    case Repo.update(changeset) do
      {:ok, showing} ->
        conn
        |> put_flash(:info, "Showing updated successfully.")
        |> redirect(to: showing_path(conn, :show, showing))
      {:error, changeset} ->
        render(conn, "edit.html",
          showing: showing,
          changeset: changeset,
          theaters: theater_dropdowns,
          movies: movie_dropdowns )
    end
  end

  def delete(conn, %{"id" => id}) do
    showing = Repo.get!(Showing, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(showing)

    conn
    |> put_flash(:info, "Showing deleted successfully.")
    |> redirect(to: showing_path(conn, :index))
  end

  defp theater_dropdowns do
    Repo.all(MovieStore.Theater)
    |> Enum.map( fn theater -> {theater.name, theater.id} end )
  end

  defp movie_dropdowns do
    Repo.all(MovieStore.Movie)
    |> Enum.map( fn movie -> {movie.name, movie.id} end )
  end
end
