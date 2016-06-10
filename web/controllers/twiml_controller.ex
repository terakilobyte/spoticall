defmodule Spoticall.TwimlController do
  use Spoticall.Web, :controller

  alias Spoticall.Twiml

  plug :scrub_params, "twiml" when action in [:create, :update]

  def index(conn, _params) do
    twiml = Repo.all(Twiml)
    render(conn, "index.html", twiml: twiml)
  end

  def new(conn, _params) do
    changeset = Twiml.changeset(%Twiml{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"twiml" => twiml_params}) do
    changeset = Twiml.changeset(%Twiml{}, twiml_params)

    case Repo.insert(changeset) do
      {:ok, _twiml} ->
        conn
        |> put_flash(:info, "Twiml created successfully.")
        |> redirect(to: twiml_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    twiml = Repo.get!(Twiml, id)
    render(conn, "show.html", twiml: twiml)
  end

  def edit(conn, %{"id" => id}) do
    twiml = Repo.get!(Twiml, id)
    changeset = Twiml.changeset(twiml)
    render(conn, "edit.html", twiml: twiml, changeset: changeset)
  end

  def update(conn, %{"id" => id, "twiml" => twiml_params}) do
    twiml = Repo.get!(Twiml, id)
    changeset = Twiml.changeset(twiml, twiml_params)

    case Repo.update(changeset) do
      {:ok, twiml} ->
        conn
        |> put_flash(:info, "Twiml updated successfully.")
        |> redirect(to: twiml_path(conn, :show, twiml))
      {:error, changeset} ->
        render(conn, "edit.html", twiml: twiml, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    twiml = Repo.get!(Twiml, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(twiml)

    conn
    |> put_flash(:info, "Twiml deleted successfully.")
    |> redirect(to: twiml_path(conn, :index))
  end
end
