defmodule BotFramework.Callback do
  alias BotFramework.Models.{Activity, Attachment}

  @callback handle_activity(Activity.t) :: Activity
end
