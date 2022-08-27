defmodule Lebotski.Bot.Templates.MissingLocationTemplate do
  def to_message(%{command: command}) do
    %{
      blocks: [
        %{
          type: "header",
          text: %{
            type: "plain_text",
            text: "Looks like I need a location, man",
            emoji: true
          }
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text: ":boom: Strikes & gutters, ups and downs.\n\n "
          }
        },
        %{
          type: "divider"
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text: " "
          }
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text:
              "I don't know where to search, man. You never gave me a location.\n\nTry something like `#{command} Los Angeles`"
          },
          accessory: %{
            type: "image",
            image_url:
              "https://i.guim.co.uk/img/media/6769edf9e592492d041b184af8bcba1bf786fcdc/0_702_3165_1899/master/3165.jpg?width=700&quality=85&auto=format&fit=max&s=467344a58c159ca5310862c6dbe282d9",
            alt_text: "I need a location, man."
          }
        }
      ],
      text: "Looks like I need a location, man"
    }
  end
end
