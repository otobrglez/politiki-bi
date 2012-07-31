require "spec_helper"

describe API do
	include Rack::Test::Methods
	def app() API; end

	context "MDX query" do
		it "should break on missing MDX" do
			post "/mdx"
			last_response.status.should_not == 200
			Oj.load(last_response.body)["error"].should =~ /missing/i
		end

		it "should brake on wrong MDX" do
			post "/mdx", { :mdx => "SELECT fail" }
			last_response.status.should_not == 200
			last_response.headers['Content-Type'].should eql 'application/json'
			Oj.load(last_response.body)["error"].should =~ /Mondrian Error/
		end

		it "should do real MDX with responses" do
			post "/mdx", {
				:mdx => <<-MDX
					SELECT {[Parameters].children } ON COLUMNS,
						{[Targets].[politician].children } ON ROWS
					FROM [Measurements]
					WHERE ([Time].[2012])					
				MDX
			}

			last_response.status.should == 201
			out = Oj.load(last_response.body)
		end
	end
end