defmodule BotFramework.Models.Activity do
  alias BotFramework.Models.{Conversation, ChannelAccount, Attachment}

  defstruct [:id, :channelId, :conversation, :from, :recipient, :serviceUrl,
   :type, :text, :attachments, :channelData, :entities, :timestamp]

  @type t :: %__MODULE__{
    id: String.t, channelId: String.t, conversation: Conversation.t,
    from: ChannelAccount.t, recipient: ChannelAccount.t, serviceUrl: String.t,
    type: String.t, text: String.t, attachments: [Attachment.t], channelData: any,
    entities: list, timestamp: String.t
  }

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
