defmodule TopRole.GameRoom do
  use Ecto.Schema
  import Ecto.Changeset
  alias TopRole.GameRoom

  schema "game_rooms" do
    belongs_to :owner, TopRole.User, foreign_key: :owner_id, references: :id
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%GameRoom{} = game_room, attrs) do
    game_room
    |> cast(attrs, [:owner_id, :description])
    |> validate_required([:owner_id])
  end
end
