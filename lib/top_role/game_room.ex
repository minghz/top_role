defmodule TopRole.GameRoom do
  use Ecto.Schema
  import Ecto.Changeset
  alias TopRole.GameRoom

  schema "game_rooms" do
    belongs_to :user, TopRole.Users.User
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%GameRoom{} = game_room, attrs) do
    game_room
    |> cast(attrs, [:user_id, :description])
    |> validate_required([:user_id])
  end
end
