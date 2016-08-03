defmodule BotFramework.Callback do
  alias BotFramework.Models.{Activity, Attachment}

  @callback handle_activity(Activity.t) :: Activity
  @callback handle_message(String.t) :: Activity
  @callback handle_attachments([Attachment.t]) :: Activity
end
