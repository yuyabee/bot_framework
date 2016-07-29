defmodule BotFramework.Models.ChannelAccount do
  defstruct [:id, :name]

  def decoding_map, do: %__MODULE__{}
end
