defmodule Lebotski.Bot.Templates.SearchingErrorTemplate do
  def to_message(%{command: command, error: error}) do
    %{
      blocks: [
        %{
          type: "header",
          text: %{
            type: "plain_text",
            text: "Some things have come to light",
            emoji: true
          }
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text: ":foot: Just my opinion man, but an error occured...\n\n "
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
            text: error
          },
          accessory: %{
            type: "image",
            image_url:
              "https://static1.srcdn.com/wordpress/wp-content/uploads/the-big-lebowski1.jpg?q=50&fit=crop&w=1500&dpr=1.5",
            alt_text: "Rug-pee-ers did not do this man"
          }
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text: "Try again with another location. (e.g. `#{command} Los Angeles, CA`)"
          }
        }
      ],
      text: "Just my opinion man, but an error occured - #{error}"
    }
  end
end
