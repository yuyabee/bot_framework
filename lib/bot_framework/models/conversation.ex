defmodule BotFramework.Models.Conversation do
  defstruct [:id, :isGroup]

  def decoding_map, do: %__MODULE__{}
end
