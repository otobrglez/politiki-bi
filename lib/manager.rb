# By Oto Brglez - <oto.brglez@opalab.com>

require 'java'
require 'active_support'
require 'active_record'
require 'active_support/dependencies'
require 'logger'
require 'jdbc/mysql'
require 'lib/politiki_olap_schema'
require 'lib/models'
require 'httparty'
require 'erb'

class Hash

	# This is monkey patch couse mondrian-olap requires
	# symbols as keys for Connection Hash.
	def keys_to_symbols!
		self.keys.inject({}) { |i,k|
			i.merge!({k.to_sym => self.values_at(k).first}) }
	end
end

class Manager

	attr_accessor :olap

	def initialize
 		ActiveRecord::Base.logger = Logger.new(STDOUT)
		::ActiveSupport::Dependencies.autoload_paths = %w(lib/models models)
		ActiveRecord::Base.establish_connection(self.config["database"])
	end

	def olap
		@olap ||= Mondrian::OLAP::Connection.create(self.config["olap"].keys_to_symbols!.merge!({
			:schema => PolitikiOlapSchema.olap_schema
		}))
	end

	def config
		@config ||= YAML.load(ERB.new(File.read("config.yml")).result) [ENV["RACK_ENV"] || "development"]
	end

	def measurement id
		HTTParty.get("#{config['politiki_uri']}#{id}/denormalized.json",{
			:basic_auth => {:username => config['username'], :password => config['password']}
		})
	end
end