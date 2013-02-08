$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "rubygems"
require "bundler"
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require "rake"

require "rspec/core"
require "rspec/core/rake_task"

require "mongoid/bitfield/version"

require "jeweler"
Jeweler::Tasks.new do |gem|
  gem.name = "mongoid_bitfield"
  gem.version = Mongoid::Bitfield::VERSION
  gem.homepage = "http://github.com/asaaki/mongoid_bitfield"
  gem.license = "MIT"
  gem.summary = %Q{Mongoid::Bitfield stores boolean flags as single property in DB.}
  gem.description = %Q{Mongoid::Bitfield stores boolean flags as single property in MongoDB.}
  gem.email = "chris@dinarrr.com"
  gem.authors = ["Christoph Grabo"]
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
