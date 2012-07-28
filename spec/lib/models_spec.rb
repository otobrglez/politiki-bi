require "spec_helper"

describe "Models from system" do
	
	let(:manager){ Manager.new }

	context "FMeasurement" do
		let(:m){ FMeasurement.new }

		it "has some attributes" do
			m.should respond_to :d_time, :d_parameter, :d_target
		end
	end

	context "Storing measurement" do
		
		it "can be stored" do
			m = read_json "denormalized-JJansaSDS-twitter_friends_count.json"
			m.should_not == nil

			m["parameter"].should_not be_nil
		end
	
		it "should make new record for measurement from json" do
			me = FMeasurement.new_from_denormalized read_json("denormalized-JJansaSDS-twitter_friends_count.json")
			me2 = FMeasurement.new_from_denormalized read_json("denormalized_4fd9a043ba6fc0502c00007b.json")
			me3 = FMeasurement.new_from_denormalized read_json("denormalized_4fe3118aba6fc02eb5001c45.json")
		
			me.id.should_not be_nil
			me2.id.should_not be_nil
			me3.id.should_not be_nil
		end


	end

end