# frozen_string_literal: true

require 'openai'

# This is a wrapper for OpenAI
class MyAi
  attr_reader :ai, :model

  def initialize(model = 'gpt-4o-mini')
    @ai = OpenAI::Client.new(api_key: ENV.fetch('OPENAI_API_KEY', nil))
    @model = model
  end

  def talk
    messages = [{ role: 'user', content: 'Say this is a test' }]

    ai.chat.completions.create(messages: messages, model: ai_model)
  end

  private

  def ai_model
    model.to_sym
  end
end
