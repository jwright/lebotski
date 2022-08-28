defmodule Lebotski.Bot.Templates.SearchResultsTemplate do
  alias Lebotski.Bot.{Actions, Templates.SearchResultsCategoryImage}

  def to_message(%{category: category, image_url: image_url, location: location, results: results}) do
    %{
      blocks:
        [
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
              text:
                "Found *#{results["total"]}* #{category.description} near _#{location.address}_."
            },
            accessory: SearchResultsCategoryImage.to_message(image_url, category)
          },
          %{
            type: "divider"
          }
        ] ++ results_blocks(results),
      text: "There are some results here, man"
    }
  end

  defp results_blocks(results) do
    results["businesses"]
    |> Enum.flat_map(&result_block/1)
  end

  defp result_block(
         %{
           "id" => id,
           "name" => name,
           "image_url" => image_url,
           "url" => url
         } = result
       ) do
    address = address(result)
    star_rating = star_rating(result)
    review_count = review_count(result)

    [
      %{
        type: "section",
        text: %{
          type: "mrkdwn",
          text: "*#{name}*\n\n#{star_rating} #{review_count}\n\n #{address}"
        },
        accessory: %{
          type: "image",
          image_url: image_url,
          alt_text: "An image of #{name}, located at #{address}"
        }
      },
      %{
        type: "actions",
        elements: [
          %{
            type: "button",
            text: %{
              type: "plain_text",
              text: "More...",
              emoji: true
            },
            value: id,
            url: url,
            action_id: Actions.Locations.more_info()
          }
        ]
      },
      %{
        type: "divider"
      }
    ]
  end

  defp address(%{"location" => %{"display_address" => display_address}}),
    do: display_address |> Enum.join("\n")

  defp address(_), do: nil

  defp review_count(%{"review_count" => review_count}),
    do: "#{review_count} #{Inflex.inflect("review", review_count)}"

  defp review_count(_), do: nil

  defp star_rating(%{"rating" => rating}), do: star_rating(rating)

  defp star_rating(rating) when is_float(rating), do: ":star:" |> String.duplicate(trunc(rating))

  defp star_rating(_), do: nil
end
