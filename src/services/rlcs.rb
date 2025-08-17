# frozen_string_literal: true

require_relative 'my_ai'

# Gives information about RLCS
class RLCS
  def call
    site = 'https://liquipedia.net/rocketleague/Rocket_League_Championship_Series'
    # rubocop:disable Layout/LineLength
    messages = [
      {
        role: 'user',
        content: "Can you go to #{site} and list all winners in order including which players where on the team?",
      },
    ]
    # rubocop:enable Layout/LineLength
    MyAi.new('gpt-4o-mini-search-preview').create(messages).response_content
  end
end
