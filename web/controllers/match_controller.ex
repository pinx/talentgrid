defmodule Talentgrid.MatchController do
  use Talentgrid.Web, :controller

  alias Talentgrid.{User, Like}

  def index(conn, _params) do
    current_user = get_session(conn, :current_user)
    user_id = current_user.id
    nb_query = from l in Like,
      where: l.user_id == ^user_id,
      select: count(l.id)
    nb_of_likes = Repo.one(nb_query)
    employer_matches = from l in Like,
      join: ol in Like, on: l.page_id == ol.page_id,
      join: ou in User, on: ol.user_id == ou.id,
      where: ou.roles == "employer",
      where: l.user_id == ^user_id,
      group_by: [ol.user_id, ou.name, ou.avatar],
      select: %{user_id: ol.user_id, name: ou.name, avatar: ou.avatar, count: count(l.id)}
    employers = Repo.all(employer_matches)
      |> Enum.map( &(Map.put(&1, :pct, round(100 * &1.count / nb_of_likes))) )
      |> Enum.sort( &(&1.count > &2.count) )
    render(conn, "index.html", matches: employers)
  end

end
