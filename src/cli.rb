# frozen_string_literal: true

require_relative 'services/my_ai'

# This is the main class used by the Thorfile
class CLI
  def self.ai
    puts MyAi.new.talk
  end
end
