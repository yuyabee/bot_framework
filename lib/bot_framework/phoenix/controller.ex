defmodule BotFramework.Phoenix.Controller do
  defmacro __using__(_) do
    quote do
      alias BotFramework.{Client}
      alias BotFramework.Models.{Activity}

      def handle_activity(conn, params) do
        {:ok, activity} = params |> Activity.parse

        res = handle_activity(activity)

        Client.send_message(activity, res)

        json(conn, %{message: "Success"})
      end
    end
  end
end
