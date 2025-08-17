# frozen_string_literal: true

require_relative 'services/my_ai'
require_relative 'services/ewc'

# This is the main class used by the Thorfile
class CLI
  def self.ai
    MyAi.new.talk.response_content
  end

  # rubocop:disable Layout/LineLength
  def self.ewc
    pages = EWC.new.call
    messages = [
      { role: 'system', content: 'You are a esport research assistant who summarizes information about esport events.' },
      { role: 'user',   content: "Summarize the Rocket League tournament so far in the Esports World Cup including which teams that participates, teams remaining, latest match results and next matches from these sources:\n\n#{pages.join("\n\n")}" },
    ]
    MyAi.new.create(messages).response_content
  end
  # rubocop:enable Layout/LineLength
end
