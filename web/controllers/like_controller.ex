defmodule Talentgrid.LikeController do
  use Talentgrid.Web, :controller

  alias Talentgrid.Like

  plug :scrub_params, "like" when action in [:create, :update]
  
  require Logger

  def index(conn, _params) do
    # likes = Repo.all(Like)
    current_user = get_session(conn, :current_user)
    {:json, %{"data" => likes}} = Facebook.myLikes(current_user.facebook_token)
    Logger.debug(inspect likes)
    refresh_db_likes(likes, current_user)
    db_likes = Repo.all(from l in Like, where: l.user_id == ^current_user.id)
    render(conn, "index.json", likes: db_likes)
  end

  defp get_db_likes(user) do
    Repo.get_by(Like, user_id: user.id)
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
