defmodule Talentgrid.ImportController do
  use Talentgrid.Web, :controller

  alias Talentgrid.Trace

  require Logger

  def index(conn, _params) do
    # imports = Repo.all(Import)
    render(conn, "index.html", imports: [])
  end

  # def new(conn, _params) do
  #   changeset = Import.changeset(%Import{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"import_file" => import_file}) do
    File.stream!(import_file.path)
    |> CSV.decode(headers: false, strip_cells: true)  #(separator: ?;)
    |> Enum.map(fn row -> import_trace(row) end)
    # changeset = Import.changeset(%Import{}, import_params)

    # case Repo.insert(changeset) do
    #   {:ok, _import} ->
        conn
        |> put_flash(:info, "Import created successfully.")
        |> redirect(to: import_path(conn, :index))
    #   {:error, changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end

  defp import_trace(line) do 
    [author, subreddit_id, created_utc] = line
    case Integer.parse(created_utc) do
      {dt, _rem} -> 
        case Ecto.DateTime.cast(Convert.from_timestamp(dt)) do
          {:ok, datetime} ->
            %Trace{
              user_name: author,
              subject_id: subreddit_id,
              created_at: datetime
            }
            |> Repo.insert!()
          :error -> nil
        end
      :error -> nil
    end
  end

  # def show(conn, %{"id" => id}) do
  #   import = Repo.get!(Import, id)
  #   render(conn, "show.html", import: import)
  # end

  # def edit(conn, %{"id" => id}) do
  #   import = Repo.get!(Import, id)
  #   changeset = Import.changeset(import)
  #   render(conn, "edit.html", import: import, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "import" => import_params}) do
  #   import = Repo.get!(Import, id)
  #   changeset = Import.changeset(import, import_params)

  #   case Repo.update(changeset) do
  #     {:ok, import} ->
  #       conn
  #       |> put_flash(:info, "Import updated successfully.")
  #       |> redirect(to: import_path(conn, :show, import))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", import: import, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   import = Repo.get!(Import, id)

  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(import)

  #   conn
  #   |> put_flash(:info, "Import deleted successfully.")
  #   |> redirect(to: import_path(conn, :index))
  # end
end
