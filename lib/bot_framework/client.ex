defmodule BotFramework.Client do
  require Logger

  alias BotFramework.{AuthenticationServer}
  alias BotFramework.Models.{Activity}
  alias HTTPoison.{Response}

  def send_message(%Activity{
    type: type,
    serviceUrl: service_url,
    channelId: channel_id,
    conversation: %{id: conversation_id},
    id: activity_id,
    from: from,
    recipient: recipient
  } = activity, res) do

    payload = %{
      channelId: channel_id,
      conversation: activity.conversation,
      from: recipient,
      recipient: from,
      serviceUrl: service_url,
      type: type,
    } |> Kernel.struct(res)
      |> Poison.encode!

    url =
      [String.trim_trailing(service_url, "/"), "v3", "conversations",
       URI.encode_www_form(conversation_id), "activities", URI.encode_www_form(activity_id)]
      |> Enum.join("/")

    case HTTPoison.post(url, payload, headers) do
      {:ok, %Response{status_code: status_code, body: body, headers: res_headers}} ->
        case status_code do
          sc when sc in 200..202 ->
            Logger.info "Success"
          _ ->
            Logger.info "Error"
            Logger.info "sent data"
            Logger.info inspect(headers)
            Logger.info inspect(activity)
            Logger.info "received data"
            Logger.info inspect(payload)
            Logger.info status_code
            Logger.info inspect(res_headers)
            Logger.info inspect(body)
        end
      {:error, msg} ->
        Logger.info "Error"
        Logger.info inspect(msg)
    end
  end

  def headers do
    [
      {"Content-Type", "application/json"},
      {"Accept", "application/json"},
      {"Authorization", "Bearer " <> Map.fetch!(AuthenticationServer.get(:token), "access_token")}
    ]
  end
end
