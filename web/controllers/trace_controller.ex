defmodule Talentgrid.TraceController do
  use Talentgrid.Web, :controller

  alias Talentgrid.Trace

  def index(conn, _params) do
    current_user = get_session(conn, :current_user)
    likes =
      case Facebook.myLikes(current_user.facebook_token) do
        {:json, %{"data" => data}} ->
          data
        {:error, error} -> 
          Plogger.debug(error, "Error")
          []
      end
    refresh_likes(likes, current_user)
    user_id = current_user.id
    db_traces = Repo.all(from l in Trace, where: l.user_id == ^user_id)
    render(conn, "index.html", traces: db_traces)
  end

  def show(conn, %{"id" => id}) do
    trace = Repo.get!(Trace, id)
    render(conn, "show.html", trace: trace)
  end


  defp refresh_likes(likes, user) do
    for like <- likes do
      created_time = case Ecto.DateTime.cast(like["created_time"]) do
        :error -> nil
        dt -> dt
      end
      new_trace = %{
        user_id: user.id,
        subject_id: like["id"],
        user_name: like["name"],
        created_time: created_time
        }
        |> Plogger.debug("New trace")
      case Repo.insert(Trace.changeset(%Trace{}, new_trace)) do
        {:error, _changeset} -> nil  # ignore for now
        :ok -> nil
      end
    end
  end
end
