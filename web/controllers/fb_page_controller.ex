defmodule Talentgrid.FbPageController do
  use Talentgrid.Web, :controller

  alias Talentgrid.FbPage

  plug :scrub_params, "fb_page" when action in [:create, :update]

  def index(conn, _params) do
    fb_pages = Repo.all(FbPage)
    render(conn, "index.html", fb_pages: fb_pages)
  end

  def new(conn, _params) do
    changeset = FbPage.changeset(%FbPage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fb_page" => fb_page_params}) do
    changeset = FbPage.changeset(%FbPage{}, fb_page_params)

    case Repo.insert(changeset) do
      {:ok, _fb_page} ->
        conn
        |> put_flash(:info, "Fb page created successfully.")
        |> redirect(to: fb_page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fb_page = Repo.get!(FbPage, id)
    render(conn, "show.html", fb_page: fb_page)
  end

  def edit(conn, %{"id" => id}) do
    fb_page = Repo.get!(FbPage, id)
    changeset = FbPage.changeset(fb_page)
    render(conn, "edit.html", fb_page: fb_page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fb_page" => fb_page_params}) do
    fb_page = Repo.get!(FbPage, id)
    changeset = FbPage.changeset(fb_page, fb_page_params)

    case Repo.update(changeset) do
      {:ok, fb_page} ->
        conn
        |> put_flash(:info, "Fb page updated successfully.")
        |> redirect(to: fb_page_path(conn, :show, fb_page))
      {:error, changeset} ->
        render(conn, "edit.html", fb_page: fb_page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fb_page = Repo.get!(FbPage, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(fb_page)

    conn
    |> put_flash(:info, "Fb page deleted successfully.")
    |> redirect(to: fb_page_path(conn, :index))
  end
end
