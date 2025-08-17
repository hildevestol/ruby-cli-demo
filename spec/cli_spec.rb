# frozen_string_literal: true

require 'cli'

describe CLI do
  describe '.ewc' do
    subject(:ewc) do
      VCR.use_cassette('ewc') do
        described_class.ewc
      end
    end

    it 'gets information from ai' do
      file = File.read(File.expand_path('./support/ewc.md', __dir__))
      expect(file).to eq_ignoring_whitespace(ewc)
    end
  end
end
