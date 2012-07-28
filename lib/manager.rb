# By Oto Brglez - <oto.brglez@opalab.com>

require 'active_support'
require 'active_record'
require 'active_support/dependencies'
require 'logger'
require 'lib/models'

class Manager

	def initialize
 		ActiveRecord::Base.logger = Logger.new(STDOUT)
		::ActiveSupport::Dependencies.autoload_paths = %w(lib/models models)
		ActiveRecord::Base.establish_connection(self.config["database"])
	end

	def config
		@config ||= YAML.load(File.read("config.yml"))[ENV["RACK_ENV"] || "development"]
	end
end