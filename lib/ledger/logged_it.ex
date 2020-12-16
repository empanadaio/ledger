defmodule Ledger.LoggedIt do
  @derive Jason.Encoder
  defstruct [
    :topic,
    :message,
    :received_by_pid,
    :received_by_node,
    :ctrl_pid,
    :ctrl_node
  ]
end
