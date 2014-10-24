$LOAD_PATH.unshift(File.expand_path("../../lib",__FILE__))

# require "database_cleaner"
require "mongoid"
require "mongoid_bitfield"

RSpec.configure do |config|
  config.before(:suite) do
    Mongoid.purge!
  end
end

Mongoid.configure do |config|
  config.connect_to("mongoid_bitfield_test")
end
