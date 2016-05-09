defmodule Talentgrid.LikeController do
  use Talentgrid.Web, :controller

  alias Talentgrid.Like

  require Logger

  # select other.user_id, count(*) from likes
  # inner join likes as other
  # on likes.page_id = other.page_id
  # where likes.user_id = 100011990117480
  # group by other.user_id

  def index(conn, _params) do
    # likes = Repo.all(Like)
    current_user = get_session(conn, :current_user)
    likes =
      case Facebook.myLikes(current_user.facebook_token) do
        {:json, %{"data" => data}} ->
          data
        {:error, error} -> 
          Logger.warn(inspect error)
          []
      end
    Logger.debug(inspect likes)
    refresh_db_likes(likes, current_user)
    user_id = current_user.id
    db_likes = Repo.all(from l in Like, where: l.user_id == ^user_id)
    render(conn, "index.html", likes: db_likes)
  end

  def show(conn, %{"id" => id}) do
    like = Repo.get!(Like, id)
    render(conn, "show.html", like: like)
  end


 defp refresh_db_likes(likes, user) do
    for like <- likes do
      # like = like
      #   |> Map.put("page_id", like["id"])
      #   |> Map.put("facebook_uid", user.facebook_uid)
      #   |> Map.delete("id")
      created_time = case Ecto.DateTime.cast(like["created_time"]) do
        :error -> nil
        dt -> dt
      end
      new_like = %{
        user_id: user.id,
        page_id: like["id"],
        name: like["name"],
        created_time: created_time
        }
      Logger.debug(inspect new_like)
      case Repo.insert(Like.changeset(%Like{}, new_like)) do
        {:error, changeset} -> nil
        :ok -> nil
      end
    end
  end
end
