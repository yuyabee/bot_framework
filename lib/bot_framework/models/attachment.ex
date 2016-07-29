defmodule BotFramework.Models.Attachment do
  defstruct [:contentType, :content]

  def decoding_map, do: %__MODULE__{}
end
