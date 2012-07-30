require "mondrian-olap"

class PolitikiOlapSchema

  def self.olap_schema
    Mondrian::OLAP::Schema.define do
      cube 'Measurements' do
        table 'f_measurements'
        
        dimension 'Targets', :foreign_key => 'd_target_id' do
          hierarchy :has_all => true, :all_member_name => 'All targets', :primary_key => 'id' do
            table 'd_targets'
            level 'Type', :column => 'm_type', :unique_members => true
            level 'Target', :column => 'target', :unique_members => true
          end
        end

        dimension 'Parameters', :foreign_key => 'd_parameter_id' do
          hierarchy :has_all => true, :all_member_name => 'All parameters', :primary_key => 'id' do
            table 'd_parameters'
            level 'Parameter', :column => 'parameter', :unique_members => true
          end
        end

      dimension 'Time', :foreign_key => 'd_time_id', :type => 'TimeDimension' do
        hierarchy :has_all => false, :primary_key => 'id' do
          table 'd_times'
          level 'Year', :column => 'year', :type => 'Numeric', :unique_members => true, :level_type => 'TimeYears'
          level 'Month', :column => 'month', :type => 'Numeric', :unique_members => false, :level_type => 'TimeMonths'
          level 'Day', :column => 'day', :type  => 'Numeric', :unique_members => true, :level_type => 'TimeDays'
        end
      end

        measure 'Value', :column => 'value', :aggregator => 'max'
      end
    end
  end

end