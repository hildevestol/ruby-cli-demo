# frozen_string_literal: true

require 'fetch_page'
require 'liquipedia_url'

describe FetchPage do
  subject(:fetch_page) { described_class.new }

  describe '#fetch_from_urls' do
    let(:urls) do
      liquipedia = LiquipediaURL.new('rocketleague', 'Esports_World_Cup/2025')
      [
        liquipedia.section(1),
        liquipedia.section(2),
        liquipedia.section(4),
        liquipedia.section(11),
      ]
    end

    let(:pages) do
      VCR.use_cassette('pages') do
        fetch_page.fetch_from_urls(urls, 100)
      end
    end

    it 'builds data in four pages' do
      expect(pages.length).to be(4)
    end

    it 'all pages contain data' do
      expect(pages).to all(include('Esports World Cup/2025'))
    end
  end
end
