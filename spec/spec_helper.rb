require "mongoid"
require "mongoid_bitfield"

RSpec.configure do |config|
  config.after(:each) do
    Mongoid.purge!
    Mongoid::IdentityMap.clear if defined?(Mongoid::IdentityMap)
  end
end

Mongoid.configure do |config|
  config.connect_to("mongoid_bitfield_test")
end
