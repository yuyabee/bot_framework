defmodule BotFramework.Models.Conversation do
  defstruct [:id, :isGroup]

  @type t :: %__MODULE__{
    id: String.t, isGroup: boolean
  }

  def decoding_map, do: %__MODULE__{}
end
