defmodule Ledger.Repo.Migrations.CreateRetailerAffinities do
  use Ecto.Migration

  def change do
    create table(:retailer_affinities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :profile_id, :uuid, null: false
      add :retailer, :string, null: false
      add :count, :integer, null: false

      timestamps()
    end

    create unique_index(:retailer_affinities, [:profile_id])
  end
end
