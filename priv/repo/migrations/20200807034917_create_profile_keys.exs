defmodule Ledger.Repo.Migrations.CreateProfileKeys do
  use Ecto.Migration

  def change do
    create table(:profile_keys, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :binary

      timestamps()
    end
  end
end
