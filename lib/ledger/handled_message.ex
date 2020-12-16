defmodule Ledger.HandledMessage do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "handled_messages" do
    field :topic, :string
    field :message, :string
    field :handled_by_node, :string
    field :handled_by_pid, :string
    field :received_by_node, :string
    field :received_by_pid, :string
    field :ctrl_node, :string
    field :ctrl_pid, :string

    timestamps()
  end

  @doc false
  def changeset(handled_message, attrs) do
    handled_message
    |> cast(attrs, [
      :received_by_pid,
      :received_by_node,
      :handled_by_pid,
      :handled_by_node,
      :ctrl_pid,
      :ctrl_node,
      :message
    ])
    |> validate_required([
      :received_by_pid,
      :received_by_node,
      :handled_by_pid,
      :handled_by_node,
      :ctrl_pid,
      :ctrl_node,
      :message
    ])
  end
end
