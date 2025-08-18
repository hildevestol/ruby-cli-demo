# frozen_string_literal: true

require_relative 'services/my_ai'
require_relative 'services/ewc'
require_relative 'services/rlcs'
require_relative 'services/tournament'
require_relative 'helpers/md_file'

# This is the main class used by the Thorfile
class CLI
  def self.ai
    MyAi.new.talk.response_content
  end

  # rubocop:disable Metrics/MethodLength, Layout/LineLength
  def self.ewc
    pages = EWC.new.call
    messages = [
      { role: 'system', content: 'You are a esport research assistant who summarizes information about esport events.' },
      { role: 'user',   content: "Summarize the Rocket League tournament so far in the Esports World Cup including which teams that participates, teams remaining, latest match results and next matches from these sources:\n\n#{pages.join("\n\n")}" },
    ]

    res = MyAi.new.create(messages).response_content
    Helpers::MdFile.new.write_with_timestamp(
      name: 'ewc',
      content: res,
    )
    res
  end
  # rubocop:enable Metrics/MethodLength, Layout/LineLength

  def self.rlcs
    res = RLCS.new.call
    Helpers::MdFile.new.write_with_timestamp(
      name: 'rlcs',
      content: res,
    )
    res
  end

  def self.tournaments
    res = Tournament.new.call
    Helpers::MdFile.new.write_with_timestamp(
      name: 'tournaments',
      content: res,
    )
    res
  end
end
