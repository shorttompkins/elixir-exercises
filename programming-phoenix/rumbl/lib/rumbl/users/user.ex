defmodule Rumbl.Users.User do
  # defstruct [:id, :name, :username, :password]
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Users.User

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Media.Video

    timestamps()
  end

  # Good for just updating the User model (generic registration, profile, etc, not password specific)
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :username, :password_hash])
    |> validate_required([:username])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username, message: "Username already taken!")
  end

  # Specifically for creating a new account when dealing with passwords
  def registration_changeset(model, attrs) do
    model
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  # Salt the password has and save that instead so we can decrypt users passwords instead of storing them!
  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end
