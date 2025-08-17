# frozen_string_literal: true

require 'openai'

# This is a wrapper for OpenAI
class MyAi
  attr_reader :ai, :model, :response

  def initialize(model = 'gpt-4o-mini')
    @ai = OpenAI::Client.new(
      api_key: ENV.fetch('OPENAI_API_KEY', nil),
      timeout: 10_000,
      max_retries: 0,
    )
    @model = model
    @response = nil
  end

  def talk
    create([{ role: 'user', content: 'Say this is a test' }])
  end

  def create(messages = [])
    @response = ai.chat.completions.create(messages: messages, model: ai_model)
    self
  end

  def response_content
    raise 'no response' unless response

    response.choices.map do |choice|
      choice.message.content
    end.join('\n')
  end

  private

  def ai_model
    model.to_sym
  end
end
