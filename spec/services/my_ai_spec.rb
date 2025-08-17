# frozen_string_literal: true

require 'my_ai'

describe MyAi do
  subject(:my_ai) { described_class.new }

  it { is_expected.to have_attributes(model: 'gpt-4o-mini') }

  describe '#talk' do
    let(:result) do
      my_ai.talk
    end

    # rubocop:disable RSpec/MessageChain
    it 'calls ai methods with correct params' do
      expect(my_ai.ai).to(
        receive_message_chain(:chat, :completions, :create)
          .with(messages: anything, model: :'gpt-4o-mini')
      )
      my_ai.talk
    end
    # rubocop:enable RSpec/MessageChain

    it 'returns a OpenAI::Models::Chat::ChatCompletion' do
      expect(result).to be_a(OpenAI::Models::Chat::ChatCompletion)
    end

    it 'has correct keys' do
      expect(result.to_h).to include(
        :choices, :created, :id, :model, :object,
        :service_tier, :system_fingerprint, :usage
      )
    end
  end
end
