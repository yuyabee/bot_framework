defmodule BotFramework.Authentication do
  require Logger

  alias HTTPoison.{Response}
  alias BotFramework.AuthenticationServer

  @jwt_endpoint "https://login.microsoftonline.com/botframework.com/oauth2/v2.0/token"
  @verification_endpoint "https://api.aps.skype.com/v1"

  # TODO: token must be updated before expires
  def get_token do
    case HTTPoison.post(@jwt_endpoint, {:form, [
       grant_type: "client_credentials",
       client_id: Application.get_env(:bot_framework, :client_id),
       client_secret: Application.get_env(:bot_framework, :client_secret),
       scope: "https://api.botframework.com/.default"
     ]}, %{"Content-type" => "application/x-www-form-urlencoded"}) do
      {:ok, %Response{body: body}} ->
        body |> Poison.decode!
      {:error, _} -> Logger.info "Error"
    end
  end

  def get_open_id_metadata do
    case HTTPoison.get(@verification_endpoint <> "/.well-known/openidconfiguration") do
      {:ok, %Response{body: body}} ->
        body |> Poison.decode!
      {:error, _} -> Logger.info "Error"
    end
  end

  def get_valid_signing_keys do
    case HTTPoison.get(@verification_endpoint <> "/keys") do
      {:ok, %Response{body: body}} ->
        (body |> Poison.decode!)["keys"]
      {:error, _} -> Logger.info "Error"
    end
  end

  @doc """
  The token was sent in the HTTP Authorization header with “"Bearer” scheme
  The token is valid JSON that conforms to the JWT standard (see references)
  The token contains an issuer claim with value of https://api.botframework.com
  The token contains an audience claim with a value equivalent to your bot’s Microsoft App ID.
  The token has not yet expired. Industry-standard clock-skew is 5 minutes.
  The token has a valid cryptographic signature with a key listed in the OpenId keys document retrieved in step 1, above.
  """
  def verify_token("Bearer " <> token), do: verify_token(token)
  def verify_token(token) do
    kid = JOSE.JWT.peek_protected(token).fields["kid"]

    sig = AuthenticationServer.get(:valid_keys)
      |> Enum.find(fn (k) -> k["kid"] == kid end)

    token
    |> Joken.token
    |> Joken.with_signer(Joken.rs256(sig))
    |> Joken.with_iss("https://api.botframework.com")
    |> Joken.with_aud(Application.get_env(:bot_framework, :client_id))
    |> Joken.verify!
  end
end
