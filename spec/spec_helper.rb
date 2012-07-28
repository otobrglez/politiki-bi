require "bundler/setup"

require "rack/test"
require "oj"

require "java"

ENV["RACK_ENV"] = "test"

require "lib/manager"

# require "api"

require "helpers"

RSpec.configure do |c|
  c.include Helpers
end