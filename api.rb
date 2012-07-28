# By Oto Brglez - <oto.brglez@opalab.com>

require "bundler/setup"
require "grape"

class API < Grape::API

	get '/mdx' do
		{
			:status => "OK"
		}
	end


end