defmodule Lebotski.Bot.Templates.SearchResultsTemplate do
  def to_message(%{category: category, location: location, results: results}) do
    %{
      blocks: [
        %{
          type: "header",
          text: %{
            type: "plain_text",
            text: "There are some results here, man.",
            emoji: true
          }
        },
        %{
          type: "section",
          text: %{
            type: "mrkdwn",
            text: ":bath: Hey, Nice Marmot.\n\n "
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
            text: "Found #{results["total"]} #{category} near #{location.address}."
          },
          accessory: %{
            type: "image",
            image_url:
              "https://dangerousminds.net/content/uploads/images/made/content/uploads/images/JeffBridges_TBLsdfsdfsdf_465_291_int.jpg",
            alt_text: "Doo, doo, doo, looking out that backdoor."
          }
        }
      ],
      text: "There are some results here, man"
    }
  end
end
