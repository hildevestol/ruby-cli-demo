#!/usr/bin/env ruby

require "bundler/setup"
require 'thor'

# Add /src to load path
$LOAD_PATH.unshift File.expand_path("../src", __dir__)

# Require the main code
require "cli"

class MyCLIApp < Thor
  desc 'hello NAME', 'Greets the user with the provided NAME'
  def hello(name)
    CLI.hello(name)
  end
end

MyCLIApp.start(ARGV)
