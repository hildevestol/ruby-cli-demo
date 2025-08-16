#!/usr/bin/env ruby

require "bundler/setup"
require 'thor'

class MyCLIApp < Thor
  desc 'hello NAME', 'Greets the user with the provided NAME'
  def hello(name)
    puts "Hello, #{name}!"
  end
end

MyCLIApp.start(ARGV)
