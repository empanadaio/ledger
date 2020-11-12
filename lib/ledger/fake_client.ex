defmodule Ledger.FakeClient do
  use GenServer

  defmodule State do
    defstruct next_id: 1, responses: []
  end

  defmodule HappyResponse do
    defstruct [:id, :from, :node]
  end

  defmodule SadResponse do
    defstruct [:id, :error]
  end

  def start_link(_args \\ []) do
    GenServer.start_link(__MODULE__, %State{})
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :do_it}}
  end

  @impl true
  def handle_continue(:do_it, state) do
    {:noreply, refresh(state)}
  end

  @impl true
  def handle_info(:do_something, state) do
    {:noreply, refresh(state)}
  end

  defp refresh(state) do
    url = "https://bitfield.ngrok.io/api/log_it"

    body =
      %{
        id: state.next_id
      }
      |> Jason.encode!()

    response =
      case HTTPoison.post(url, body, [{"content-type", "application/json"}]) do
        {:ok, %{body: body, status_code: 200}} ->
          json = Jason.decode!(body)

          %HappyResponse{
            id: state.next_id,
            from: json["self"],
            node: json["node"]
          }

        {:ok, %{status_code: code}} ->
          %SadResponse{
            id: state.next_id,
            error: "Bad status: #{code}"
          }

        {:error, reason} ->
          %SadResponse{
            id: state.next_id,
            error: reason
          }
      end
      |> IO.inspect()

    new_state =
      state
      |> Map.put(:next_id, state.next_id + 1)
      |> Map.put(:responses, [response | state.responses])

    Process.send_after(self(), :do_something, 5000)
    new_state
  end
end
