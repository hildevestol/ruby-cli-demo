# frozen_string_literal: true

require_relative '../helpers/liquipedia_url'
require_relative 'fetch_page'

# Responsible for getting information about
# EWC 2025 Rocket League tournament
class EWC
  attr_reader :game, :page

  def initialize
    @game = 'rocketleague'
    @page = 'Esports_World_Cup/2025'
  end

  def call
    FetchPage.new.fetch_from_urls(urls, 20_000)
  end

  private

  def liqupedia_url
    @liqupedia_url ||= LiquipediaURL.new(game, page)
  end

  def urls
    [
      liqupedia_url.section(1),  # Info section
      liqupedia_url.section(2),  # Game format section
      liqupedia_url.section(4),  # Teams section
      liqupedia_url.section(11), # Playoff bracket section
    ]
  end
end
