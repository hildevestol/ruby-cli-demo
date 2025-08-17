# frozen_string_literal: true

require 'my_ai'

describe MyAi do
  subject(:my_ai) { described_class.new }

  it { is_expected.to have_attributes(model: 'gpt-4o-mini') }

  describe '#talk' do
    let(:result) do
      VCR.use_cassette('talk_data') do
        my_ai.talk
      end
    end

    # rubocop:disable RSpec/MessageChain, Style/TrailingCommaInArguments
    it 'calls ai methods with correct params' do
      expect(my_ai.ai).to(
        receive_message_chain(:chat, :completions, :create)
          .with(messages: anything, model: :'gpt-4o-mini')
      )
      my_ai.talk
    end
    # rubocop:enable RSpec/MessageChain, Style/TrailingCommaInArguments

    it 'returns a OpenAI::Models::Chat::ChatCompletion' do
      expect(result.response)
        .to be_a(OpenAI::Models::Chat::ChatCompletion)
    end

    it 'has correct keys' do
      expect(result.response.to_h).to include(
        :choices, :created, :id, :model, :object,
        :service_tier, :system_fingerprint, :usage,
      )
    end

    it 'can return response_content' do
      expect(result.response_content)
        .to eq('This is a test. How can I assist you further?')
    end
  end
end
