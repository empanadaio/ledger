defmodule Ledger.Repo.Migrations.AddCtrlStuffToThing do
  use Ecto.Migration

  def change do
    alter table(:handled_messages) do
      add :ctrl_pid, :string
      add :ctrl_node, :string
    end
  end
end
