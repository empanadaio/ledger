defmodule Ledger.Topic do
  defstruct [:last_message]

  def execute(_topic, command) do
    %Ledger.LoggedIt{
      topic_id: command.topic_id,
      message: command.message
    }
  end

  def apply(topic, event) do
    %{topic | last_message: event.message}
  end
end
