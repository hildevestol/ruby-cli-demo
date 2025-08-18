# frozen_string_literal: true

require 'rlcs'

describe RLCS do
  subject(:rlcs) do
    VCR.use_cassette('rlcs') do
      described_class.new.call
    end
  end

  it 'works?' do
    file = File.read(File.expand_path('../fixtures/rlcs.md', __dir__))
    expect(file).to eq_ignoring_whitespace(rlcs)
  end
end
