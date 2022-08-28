defmodule Lebotski.Bot.Templates.MissingLocationTemplate do
  def to_message(%{command: command, image_url: image_url}) do
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
            image_url: image_url,
            alt_text: "I need a location, man."
          }
        }
      ],
      text: "Looks like I need a location, man"
    }
  end
end
