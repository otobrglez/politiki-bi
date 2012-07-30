require "spec_helper"

describe API do
	include Rack::Test::Methods
	def app() API; end

	context "MDX query" do
		it "should break on missing MDX" do
			get "/mdx"
			last_response.status.should_not == 200
			Oj.load(last_response.body)["error"].should =~ /missing/i
		end

		it "should brake on wrong MDX" do
			get "/mdx", { :mdx => "SELECT fail" }
			last_response.status.should_not == 200
			last_response.headers['Content-Type'].should eql 'application/json'
			Oj.load(last_response.body)["error"].should =~ /Mondrian Error/
		end

	end
end