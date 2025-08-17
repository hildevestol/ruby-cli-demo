require 'my_ai.rb'

describe MyAi do
  subject { described_class.new }

  it { is_expected.to have_attributes(model: 'gpt-4o-mini') }

  describe '#talk' do
    let(:result) do
      subject.talk
    end

    it 'calls ai methods with correct params' do
      expect(subject.ai).to(
        receive_message_chain(:chat, :completions, :create)
          .with(messages: anything, model: 'gpt-4o-mini'.to_sym)
      )
      subject.talk
    end

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
