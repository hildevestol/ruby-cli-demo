# frozen_string_literal: true

require_relative 'services/my_ai'
require_relative 'services/fetch_page'
require_relative 'helpers/liquipedia_url'

# This is the main class used by the Thorfile
class CLI
  def self.ai
    puts MyAi.new.talk.response_content
  end

  # TODO: Refactor
  # rubocop:disable Metrics/MethodLength, Layout/LineLength
  def self.ewc
    liquipedia = LiquipediaURL.new('rocketleague', 'Esports_World_Cup/2025')
    urls = [
      liquipedia.section(1),  # Info section
      liquipedia.section(2),  # Game format section
      liquipedia.section(4),  # Teams section
      liquipedia.section(11), # Playoff bracket section
    ]
    pages = FetchPage.new.fetch_from_urls(urls, 20_000)
    messages = [
      { role: 'system', content: 'You are a esport research assistant who summarizes information about esport events.' },
      { role: 'user',   content: "Summarize the Rocket League tournament so far in the Esports World Cup including which teams that participates, teams remaining, latest match results and next matches from these sources:\n\n#{pages.join("\n\n")}" },
    ]
    puts MyAi.new.create(messages).response_content
  end
  # rubocop:enable Metrics/MethodLength, Layout/LineLength
end
