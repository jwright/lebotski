defmodule Lebotski.Bot.Templates.SearchingLocationsTemplate do
  def to_message(%{image_url: image_url, location: location, term: term}) do
    %{
      blocks: [
        %{
          type: "header",
          text: %{
            type: "plain_text",
            text: "You're searching on Slack time",
            emoji: true
          }
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text: ":toilet: It's down there somewhere...\n\n "
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
            text: "Searching for #{term} near #{location}..."
          },
          accessory: %{
            type: "image",
            image_url: image_url,
            alt_text: "It's down there somewhere..."
          }
        }
      ],
      text: "You're searching on Slack time"
    }
  end
end
