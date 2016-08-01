# BotFramework

[Microsoft Bot Framework (V3)](https://dev.botframework.com/) Client in Elixir.

## Installation

  1. Add `bot_framework` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:bot_framework, "~> 0.1.0"}]
    end
    ```

  2. Ensure `bot_framework` is started before your application:

    ```elixir
    def application do
      [applications: [:bot_framework]]
    end
    ```

  3. Configure API key:

  ```elixir
    config :bot_framework,
      client_id: "CLIENT_ID",
      client_secret: "CLIENT_SECRET"
  ```

## Usage with [Phoenix framework](https://github.com/phoenixframework/phoenix)

  1. Define route:
    ```elixir
      defmodule BotTest.Router do
        use BotFramework.Router

        # other stuff
        scope "/api", BotTest do
          bf_handler "/handle_message", MessageController
        end
      end
    ```

  2. Write handler(See [BotFramework.Callback](lib/bot_framework/callback.ex) for more information)
    ```elixir
      defmodule BotTest.MessageController do
        use BotTest.Web, :controller
        use BotFramework.Controller

        alias BotFramework.Models.{Activity}

        # handle activity other than message
        def handle_activity(%Activity{} = _activity), do: nil

        # when the activity is message
        def handle_message(text) do
          case text |> String.downcase do
            "hi" -> [text: "Hi this is elixir_api_bot"]
            "how are you?" -> [text: "Good. Thanks. And you?"]
            "hero" ->
              [text: "Hero sample", attachments: [%{
                 contentType: "application/vnd.microsoft.card.hero",
                 content: %{
                   title: "I'm a hero card",
                   subtitle: "Search Google",
                   images: [
                     %{ url: "https://www.gstatic.com/webp/gallery3/1_webp_a.png" },
                   ],
                   buttons: [%{
                     type: "openUrl",
                     title: "Google",
                     value: "https://www.google.com"
                   }]
               }}]]
            "bad" -> [text: "Okay"]
            "fine" -> [text: "Okay"]
            _ -> [text: "Pardon me?"]
          end
        end
      end
    ```

