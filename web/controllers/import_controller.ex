defmodule Talentgrid.ImportController do
  use Talentgrid.Web, :controller

  alias Talentgrid.Trace

  require Logger

  def index(conn, _params) do
    render(conn, "index.html", imports: [], count: trace_count)
  end

  def create(conn, %{"import_file" => import_file}) do
    ctype = import_file.content_type
    path = import_file.path
    cond do
      String.match?(ctype, ~r{\/csv$}) -> import_csv(path)
      String.match?(ctype, ~r{\/json$}) -> import_json(path)
    end

    conn
    |> put_flash(:info, "#{trace_count} trace records imported.")
    |> redirect(to: import_path(conn, :index))
  end

  def delete(conn, _ ) do
    Repo.delete_all(Trace)
    conn
    |> put_flash(:info, "Traces cleared successfully.")
    |> redirect(to: "/")
  end

  defp import_json(file) do
    file
    |> File.stream!()
    |> Stream.map(fn line -> decode_json(line) end)
    |> Enum.map(&insert_trace/1)
  end

  defp import_csv(file) do
    file
    |> File.stream!()
    |> CSV.decode(headers: [:author, :subreddit_id, :created_utc], strip_cells: true)  #(separator: ?;)
    |> Enum.map(&insert_trace/1)
  end

  defp decode_json(json_line) do
    case Poison.Parser.parse(json_line, [keys: :atoms]) do
      {:ok, trace} -> trace
      {:error, _} -> nil
    end
  end

  defp insert_trace(%{:author => user_name, :subreddit_id => subject_id, :created_utc => created_utc}) do
    case Integer.parse(created_utc) do
      {dt, _rem} -> 
        case Ecto.DateTime.cast(Convert.from_timestamp(dt)) do
          {:ok, datetime} ->
            %{user_name: user_name,
              subject_id: subject_id,
              source: "reddit",
              created_at: datetime }
            |> insert_trace()
          :error -> nil
        end
      :error -> nil
    end
  end
  defp insert_trace(%{:user_name => user_name, :subject_id => subject_id, :source => source, :created_at => created_at}) do
    %Trace{
      user_name: user_name,
      subject_id: subject_id,
      source: source,
      created_at: created_at }
    |> Repo.insert!()
  end
  defp insert_trace(line) do
    # unrecognized line
    line
    |> inspect
    |> Logger.warn
    nil
  end

  defp trace_count do
    Trace
    |> select([t], count(t.id))
    |> Repo.one
  end

end
