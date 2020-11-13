defmodule Ledger.Repo.Migrations.CreateHandledMessages do
  use Ecto.Migration

  def change do
    create table(:handled_messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :received_by_pid, :string
      add :received_by_node, :string
      add :handled_by_pid, :string
      add :handled_by_node, :string
      add :message, :string
      add :topic, :string

      timestamps()
    end
  end
end
