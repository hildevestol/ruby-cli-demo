# frozen_string_literal: true

# Builds correct urls to Liquipedia API
class LiquipediaURL
  def initialize(game, page)
    @base_url = "https://liquipedia.net/#{game}/api.php"
    @page = page
  end

  def section(section)
    params = {
      page: @page,
      format: 'json',
      action: 'parse',
      prop: 'parsetree',
      section: section
    }

    "#{@base_url}?#{URI.encode_www_form(params)}"
  end
end
