defmodule Rumbl.Users do
  import Ecto.Query, warn: false

  alias Rumbl.Repo
  alias Rumbl.Users.User

  def all() do
    Repo.all(User)
  end

  def get(id) do
    Enum.find all(), &(&1.id == id)
  end

  def get_by(params) do
    Enum.find all(), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert
  end

  def change_user() do
    %User{}
    |> User.changeset
  end

end
