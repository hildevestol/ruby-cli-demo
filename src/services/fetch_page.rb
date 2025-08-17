# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# Responsible for fetching data from sites
# from the given urls
class FetchPage
  def fetch_from_urls(urls, limit = 500)
    urls.map { |url| fetch_page(url, limit) }.compact
  end

  private

  def fetch_page(url, limit = 5000)
    res = Net::HTTP.get(URI(url))
    res[0..limit] # Limit size per page
  rescue StandardError => e
    puts "Failed to fetch #{url}: #{e}"
  end
end
