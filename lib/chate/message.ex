defmodule Chate.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chate.Message
  alias Chate.Repo

  schema "messages" do
    field(:message, :string)
    # field(:user_id, :id)
    belongs_to(:user, Chate.Coherence.User)

    timestamps()
  end

  def get_messages(limit \\ 20) do
    Chate.Repo.all(Chate.Message, limit: limit)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
