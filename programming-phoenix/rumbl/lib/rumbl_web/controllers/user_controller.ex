defmodule RumblWeb.UserController do
  use RumblWeb, :controller
  alias Rumbl.Users

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    users = Users.all()
    render conn, "index.html", %{users: users}
  end

  def show(conn, %{"id" => id}) do
    user = Users.get(String.to_integer(id))
    render conn, "show.html", %{user: user}
  end

  def new(conn, _params) do
    changeset = Users.change_user()
    render conn, "new.html", %{changeset: changeset}
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", %{changeset: changeset}
    end
  end
end
