defmodule RumblWeb.UserController do
  use RumblWeb, :controller
  alias Rumbl.Users

  plug :authenticate when action in [:index, :show]

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

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
