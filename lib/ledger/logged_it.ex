defmodule Ledger.LoggedIt do
  @derive Jason.Encoder
  defstruct [:topic_id, :message]
end
