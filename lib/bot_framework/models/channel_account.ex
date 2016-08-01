defmodule BotFramework.Models.ChannelAccount do
  defstruct [:id, :name]

  @type t :: %__MODULE__{
    id: String.t, name: String.t
  }

  def decoding_map, do: %__MODULE__{}
end
