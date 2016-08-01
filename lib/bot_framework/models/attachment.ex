defmodule BotFramework.Models.Attachment do
  defstruct [:contentType, :content]

  @type t :: %__MODULE__{
    contentType: String.t content: any
  }

  def decoding_map, do: %__MODULE__{}
end
