defmodule RumblWeb.VideoController do
  use RumblWeb, :controller

  alias Rumbl.Media
  alias Rumbl.Media.Video

  import Ecto, only: [build_assoc: 2, assoc: 2]

  # this overrides the default action and ensures that every controller action will have user injected as the 3rd parameter:
  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def user_videos(user) do
    assoc(user, :videos)
  end

  def index(conn, _params, user) do
    # videos = Media.list_videos()
    videos = Rumbl.Media.list_videos_by_user(user_videos(user))
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params, user) do
    # changeset = Media.change_video(%Video{})
    changeset =
      user
      |> build_assoc(:videos)
      |> Video.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, user) do
    case Media.create_video(video_params, user) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    video = Media.get_video!(user_videos(user), id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}, user) do
    video = Media.get_video!(user_videos(user), id)
    changeset = Media.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, user) do
    video = Media.get_video!(user_videos(user), id)

    case Media.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    video = Media.get_video!(user_videos(user), id)
    {:ok, _video} = Media.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end
end
