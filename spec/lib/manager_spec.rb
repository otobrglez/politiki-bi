require "spec_helper"

describe Manager do

	context "Initialization" do
		before do
			@m = Manager.new
		end

		it "has some configuration" do
			@m.config["database"].size.should_not == 0
		end

		it "should have connection config" do
			ActiveRecord::Base.connection_config[:database].should == "politiki_bi_test"
		end
	end

end