require 'openai'

class MyAi
  attr_reader :ai, :model

  def initialize(model=:"gpt-4o-mini")
    @ai = OpenAI::Client.new(api_key: ENV["OPENAI_API_KEY"])
    @model = model
  end

  def talk
    messages = [{ role: "user", content: "Say this is a test" }]

    ai.chat.completions.create(messages: messages, model: model)
  end
end
