defmodule Ledger.Repo.Migrations.CreateCustomerProfile do
  use Ecto.Migration

  def change do
    create table(:customer_profile, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :picture, :string
      add :created_at, :naive_datetime
      add :address, :string
      add :total_spent, :integer

      timestamps()
    end
  end
end
