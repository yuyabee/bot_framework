defmodule BotFramework.Callback do
  alias BotFramework.Models.{Activity}

  @callback handle_activity(Activity.t) :: Activity.t
end
