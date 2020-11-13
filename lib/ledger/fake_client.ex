defmodule Ledger.FakeClient do
  use GenServer

  @topics [
    "bread",
    "figs",
    "butter",
    "carrots",
    "kimchi"
  ]

  defmodule State do
    defstruct host: nil, next_id: 1, responses: []
  end

  defmodule HappyResponse do
    defstruct [:id, :response]
  end

  defmodule SadResponse do
    defstruct [:id, :error]
  end

  def start_link(host \\ "http://localhost:4000") do
    GenServer.start_link(__MODULE__, %State{host: host})
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :start_refreshing}}
  end

  @impl true
  def handle_continue(:start_refreshing, state) do
    {:noreply, refresh(state)}
  end

  @impl true
  def handle_info(:do_something, state) do
    {:noreply, refresh(state)}
  end

  defp refresh(state) do
    url = "#{state.host}/api/log_it"

    message_id = state.next_id

    body =
      %{
        topic: @topics |> Enum.random(),
        message: "Message #{message_id}"
      }
      |> Jason.encode!()

    response =
      case HTTPoison.post(url, body, [{"content-type", "application/json"}]) do
        {:ok, %{body: body, status_code: 200}} ->
          json = Jason.decode!(body)

          %HappyResponse{
            id: message_id,
            response: json
          }

        {:ok, %{status_code: code}} ->
          %SadResponse{
            id: message_id,
            error: "Bad status: #{code}"
          }

        {:error, reason} ->
          %SadResponse{
            id: message_id,
            error: reason
          }
      end
      |> IO.inspect()

    new_state =
      state
      |> Map.put(:next_id, message_id + 1)
      |> Map.put(:responses, [response | state.responses])

    Process.send_after(self(), :do_something, 5000)
    new_state
  end
end
