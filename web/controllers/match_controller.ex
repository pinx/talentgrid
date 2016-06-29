defmodule Talentgrid.MatchController do
  use Talentgrid.Web, :controller

  alias Talentgrid.{User, Trace, Match}

  def index(conn, _params) do
    current_user = get_session(conn, :current_user)
    user_id = current_user.id
    nb_query = from l in Trace,
      where: l.user_id == ^user_id,
      select: count(l.id)
    nb_of_likes = Repo.one(nb_query)
    employer_matches = from l in Trace,
      join: ol in Trace, on: l.subject_id == ol.subject_id,
      join: ou in User, on: ol.user_id == ou.id,
      where: ou.roles == "employer",
      where: l.user_id == ^user_id,
      group_by: [ol.user_id, ou.name, ou.avatar],
      select: %{user_id: ol.user_id, name: ou.name, avatar: ou.avatar, count: count(l.id)}
    employers = Repo.all(employer_matches)
      |> Enum.map( &(Map.put(&1, :pct, round(100 * &1.count / nb_of_likes))) )
      |> Enum.sort( &(&1.count > &2.count) )
    render(conn, "index.html", matches: employers, current_user: get_session(conn, :current_user))
  end

  def create(conn, %{"match" => match_params}) do
    changeset = Match.changeset(%Match{}, match_params)

    case Repo.insert(changeset) do
      {:ok, _match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: match_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Match not created.")
        |> redirect(to: match_path(conn, :index))
    end
  end
end
