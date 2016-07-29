defmodule BotFramework.Models.Activity do
  alias BotFramework.Models.{Conversation, ChannelAccount, Attachment}

  defstruct [:channelId, :conversation, :from, :recipient, :serviceUrl, :type,
   :id, :text, :attachments, :channelData, :entities, :timestamp]

  def parse(param), do: {:ok, Poison.Decode.decode(param, as: decoding_map)}

  def decoding_map do
    %__MODULE__{
      conversation: Conversation.decoding_map,
      from: ChannelAccount.decoding_map,
      recipient: ChannelAccount.decoding_map,
      attachments: [Attachment.decoding_map]
    }
  end
end
