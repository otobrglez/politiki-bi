class FMeasurement < ActiveRecord::Base
	validates_presence_of :value
	
	belongs_to :d_time
	belongs_to :d_parameter
	belongs_to :d_target

	# Build new Measurement from denormalized measurement object
	def self.new_from_denormalized object
		#ActiveRecord::Base.transaction do
			m = FMeasurement.new

			d_time = DTime.find_or_create_by_year_and_month_and_day(
				object["year"],object["month"],object["day"])
		
			d_parameter = DParameter.find_or_create_by_parameter(
				object["parameter"])

			d_target = DTarget.find_or_create_by_m_type_and_target_and_target_id(
				object["type"],object["target"],object["target_id"])

			m.d_time, m.d_parameter, m.d_target = d_time, d_parameter, d_target
			m.value = object["value"]

			m_ex = FMeasurement.find(:first,:conditions => {
				:d_time_id => d_time,
				:d_parameter_id => d_parameter,
				:d_target_id => d_target
			})

			if not m_ex.nil?
				m_ex.value = m.value
				m = m_ex
			end

			m.save if m.valid?
			m
		#end
	end

end

class DTime < ActiveRecord::Base
	has_many :f_measurements
	validates_presence_of :year, :month, :day
end

class DParameter < ActiveRecord::Base
	has_many :f_measurements
	validates_presence_of :parameter
end

class DTarget < ActiveRecord::Base
	has_many :f_measurements
	validates_presence_of :m_type, :target, :target_id
end