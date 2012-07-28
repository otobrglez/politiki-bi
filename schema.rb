# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "d_parameters", :force => true do |t|
    t.string "parameter"
  end

  add_index "d_parameters", ["parameter"], :name => "index_d_parameters_on_parameter"

  create_table "d_targets", :force => true do |t|
    t.string "m_type"
    t.string "target"
    t.string "target_id"
  end

  add_index "d_targets", ["m_type", "target", "target_id"], :name => "targets_g_key"
  add_index "d_targets", ["m_type"], :name => "index_d_targets_on_m_type"
  add_index "d_targets", ["target"], :name => "index_d_targets_on_target"
  add_index "d_targets", ["target_id"], :name => "index_d_targets_on_target_id"

  create_table "d_times", :force => true do |t|
    t.integer "year"
    t.integer "month"
    t.integer "day"
  end

  add_index "d_times", ["day"], :name => "index_d_times_on_day"
  add_index "d_times", ["month"], :name => "index_d_times_on_month"
  add_index "d_times", ["year", "month", "day"], :name => "times_g_keys"
  add_index "d_times", ["year"], :name => "index_d_times_on_year"

  create_table "f_measurements", :force => true do |t|
    t.integer "d_time_id"
    t.integer "d_parameter_id"
    t.integer "d_target_id"
    t.float   "value",          :default => 0.0
  end

  add_index "f_measurements", ["d_parameter_id"], :name => "index_f_measurements_on_d_parameter_id"
  add_index "f_measurements", ["d_target_id"], :name => "index_f_measurements_on_d_target_id"
  add_index "f_measurements", ["d_time_id", "d_parameter_id", "d_target_id"], :name => "measurements_g_keys"
  add_index "f_measurements", ["d_time_id"], :name => "index_f_measurements_on_d_time_id"

end
