class MigOne < ActiveRecord::Migration

	def up
		create_table :f_measurements do |t|
			t.references :d_time	
			t.references :d_parameter 
			t.references :d_target	
		
			t.column :value,	:float, 	:default => 0.0
		end

		create_table :d_times do |t|
			t.column :year, 	:integer
			t.column :month, 	:integer
			t.column :day, 		:integer
		end

		create_table :d_parameters do |t|
			t.column :parameter, 	:string
		end

		create_table :d_targets do |t|
			t.column :m_type,			:string
			t.column :target,		:string
			t.column :target_id, 	:string
		end

		add_index :f_measurements, :d_time_id
		add_index :f_measurements, :d_parameter_id
		add_index :f_measurements, :d_target_id

		add_index :f_measurements, [:d_time_id, :d_parameter_id, :d_target_id], :name => "measurements_g_keys"

		add_index :d_times, :year
		add_index :d_times, :month
		add_index :d_times, :day

		add_index :d_times, [:year, :month, :day], :name => "times_g_keys"

		add_index :d_parameters, :parameter

		add_index :d_targets, :m_type
		add_index :d_targets, :target
		add_index :d_targets, :target_id

		add_index :d_targets, [:m_type, :target, :target_id], :name => "targets_g_key"
		
	end

	def down
		%w(f_measurements d_times d_parameters d_targets).each do |t|
			drop_table(t.to_sym) if table_exists?(t.to_sym)
		end
	end

end