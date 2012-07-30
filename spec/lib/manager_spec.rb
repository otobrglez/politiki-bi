require "spec_helper"

describe Manager do

	context "Initialization" do
		let(:m) { Manager.new }

		it "has some configuration" do
			m.config["database"].size.should_not == 0
		end

		it "should have connection config" do
			ActiveRecord::Base.connection_config[:database].should == "politiki_bi_test"
		end
	end

	context "OLAP" do
		let(:m){ Manager.new }

		it "has olap" do
			m.olap.cube('Measurements').should_not be_nil
			m.olap.cube('Measurements').dimension_names.should include "Time"
			m.olap.cube('Measurements').dimension('Time').hierarchy.level_names include "Year"
		end
	end

end