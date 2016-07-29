defmodule BotFramework.AuthenticationServer do
  use GenServer

  alias BotFramework.{Authentication}

  # Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def get(key), do: GenServer.call(:authentication_server, {:get, key})

  # Server implementation

  def init([]) do
    {:ok, %{
      token: Authentication.get_token,
      open_id: Authentication.get_open_id_metadata,
      valid_keys: Authentication.get_valid_signing_keys
    }}
  end

  def handle_call({:get, key}, _from, authentication), do:
    {:reply, Map.get(authentication, key), authentication}
end
