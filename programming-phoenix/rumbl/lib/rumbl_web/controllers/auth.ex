defmodule RumblWeb.Auth do
  import Plug.Conn

  def init(opts) do
    # whatever init returns, gets passed as 2nd arg to call (with conn always first)
    Keyword.fetch!(opts, :repo)
  end

  # accepts conn always and repo since thats returned from init above
  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def login_by_username_and_pass(conn, username, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(username: username)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

end
