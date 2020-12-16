defmodule Ledger.Topic do
  defstruct [:last_message]

  def execute(_topic, command) do
    %Ledger.LoggedIt{
      topic: command.topic,
      message: command.message,
      ctrl_pid: command.ctrl_pid,
      ctrl_node: command.ctrl_node,
      received_by_pid: inspect(self()),
      received_by_node: Node.self()
    }
  end

  def apply(topic, event) do
    %{topic | last_message: event.message}
  end
end
