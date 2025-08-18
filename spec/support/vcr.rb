# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes' # Directory to store recorded interactions
  config.hook_into :webmock # or :faraday, etc., depending on your chosen library

  # Match on method, uri AND body
  # to ensure it fails if e.g. a request to AI
  # changes in code, then we want to re-record the result
  config.default_cassette_options[:match_requests_on] = [:method, :uri, :body] # default [:method, :uri]

  # Filter out sensitive information
  config.filter_sensitive_data('<OPENAI_API_KEY>') do |interaction|
    ENV['OPENAI_API_KEY']
  end
end
