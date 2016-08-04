defmodule BotFramework.Phoenix.Router do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      import BotFramework.Authentication, only: [verify_token: 1]

      def authenticate(conn, _params) do
        case conn |> get_req_header("authorization") |> List.first |> verify_token do
          {:ok, _} -> conn
          {:error, _} -> conn |> resp(403, "") |> halt
        end
      end

      pipeline :bot_framework do
        plug :accepts, ["json"]
        plug :authenticate
      end
    end
  end

  defmacro bf_handler(path, controller) do
    quote do
      scope "/" do
        pipe_through :bot_framework
        post unquote(path), unquote(controller), :handle_activity
      end
    end
  end
end
