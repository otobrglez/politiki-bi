require "json"

module Helpers

	def read_json path
		throw "JSON file #{path} is missing!" unless File.exists? "spec/static_json/#{path}"
		JSON.parse(File.read("spec/static_json/#{path}"))
	end

end