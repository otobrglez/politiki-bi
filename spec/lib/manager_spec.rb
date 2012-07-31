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
		end
	end

	context "Retriving Measurements" do
		let(:m){ Manager.new }
		
		it "can retrive measurement" do
			m.measurement("4fe3118aba6fc02eb5001c45")["type"].should =~ /media/
		end
	end

end