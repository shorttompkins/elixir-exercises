defmodule Rumbl.Media.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Media.Video


  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    # field :user_id, :id
    belongs_to :user, Rumbl.Users.User
    belongs_to :category, Rumbl.Media.Category

    timestamps()
  end

  @doc false
  def changeset(%Video{} = video, attrs \\ %{}) do
    IO.puts inspect(attrs)
    video
    |> cast(attrs, [:url, :title, :description, :category_id], [:category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
  end
end
