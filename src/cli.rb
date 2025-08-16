require_relative "services/my_ai"

class CLI
  def self.ai
    puts MyAi.new.talk
  end
end
