# By Oto Brglez - <oto.brglez@opalab.com>

require "bundler/setup"
require "lib/manager"
require "grape"

class API < Grape::API
	default_format :json
	format :json
	rescue_from :all
	error_format :json

	rescue_from Mondrian::OLAP::Error do |e|
		rack_response({ :error => "rescued from #{e.root_cause}" }.to_json, 500)
  	end
	
	helpers do
		def olap; @olap ||= Manager.new.olap; end
	end

	get '/mdx' do
		throw "Missing MDX query as parameter" if params[:mdx].nil? or params[:mdx] == ""

		out = olap.execute(params[:mdx])

		{
			:result => out
		}
	end


end