# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/tripwire.rb'

Hoe.new('tripwire', Tripwire::VERSION) do |p|
  # p.rubyforge_name = 'tripwirex' # if different than lowercase project name
  p.developer('Brendan Baldwin', 'brendan@usergenic.com')
end

desc "Generates the tripwire.gemspec file"
task :gemspec do
  system("rake debug_gem > tripwire.gemspec")
end

# vim: syntax=Ruby

