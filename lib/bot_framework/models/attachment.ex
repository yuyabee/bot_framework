defmodule BotFramework.Models.Attachment do
  defstruct [:contentType, :content, :contentUrl]

  @type t :: %__MODULE__{
    contentType: String.t content: any, contentUrl: String.t
  }

  def decoding_map, do: %__MODULE__{}
end
