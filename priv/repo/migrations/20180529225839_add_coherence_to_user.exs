defmodule Chate.Repo.Migrations.AddCoherenceToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      # rememberable
      add(:remember_created_at, :utc_datetime)
    end
  end
end
