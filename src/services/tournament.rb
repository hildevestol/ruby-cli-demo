# frozen_string_literal: true

# Fetches information about upcoming Rocket League tournaments
class Tournament
  def call
    site = 'https://liquipedia.net/rocketleague/S-Tier_Tournaments'
    # rubocop:disable Layout/LineLength
    messages = [
      {
        role: 'user',
        content: "Go to #{site} and give a list of upcoming Rocket League tournament. The list should contain when, where, link to the site, teams playing (if available) and links to english stream on Youtube or Twitch",
      },
    ]
    # rubocop:enable Layout/LineLength
    MyAi.new('gpt-4o-mini-search-preview').create(messages).response_content
  end
end
