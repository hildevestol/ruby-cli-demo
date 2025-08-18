# frozen_string_literal: true

RSpec::Matchers.define :eq_ignoring_whitespace do |expected|
  match do |actual|
    actual.gsub(/\s+/, ' ').strip == expected.gsub(/\s+/, ' ').strip
  end

  failure_message do |actual|
    "expected that '#{actual}' (normalized: '#{actual.gsub(/\s+/, ' ').strip}') would equal '#{expected}' (normalized: '#{expected.gsub(/\s+/, ' ').strip}') ignoring whitespace"
  end
end
