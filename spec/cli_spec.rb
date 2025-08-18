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
      file = File.read(File.expand_path('./fixtures/ewc.md', __dir__))
      expect(file).to eq_ignoring_whitespace(ewc)
    end
  end

  describe '.rlcs' do
    subject(:rlcs) do
      VCR.use_cassette('rlcs') do
        described_class.rlcs
      end
    end

    it 'writes file' do
      expect { rlcs }.to change { file_count('md_files/test/rlcs') }.by(1)
    end
  end
end
