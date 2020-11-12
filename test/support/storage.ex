defmodule Ledger.Storage do
  @doc """
  Reset the event store and read store databases.
  """
  def reset! do
    :ok = Application.stop(:ledger)

    reset_eventstore!()

    reset_readstore!()

    {:ok, _} = Application.ensure_all_started(:ledger)

    :ok
  end

  defp reset_eventstore! do
    {:ok, conn} =
      Ledger.EventStore.config()
      |> EventStore.Config.default_postgrex_opts()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore! do
    readstore_config = Application.get_env(:ledger, Ledger.Repo)
    config = readstore_config |> Keyword.delete(:pool)
    {:ok, conn} = Postgrex.start_link(config)

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      projection_versions,
      retailer_affinities
    RESTART IDENTITY;
    """
  end
end
