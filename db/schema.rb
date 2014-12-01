# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140528111955) do

  create_table "addcomments", :force => true do |t|
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "clientname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "dpname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "username",                           :null => false
    t.string   "password"
    t.string   "name"
    t.string   "email"
    t.integer  "department_id"
    t.integer  "state_id"
    t.string   "location"
    t.string   "memo"
    t.boolean  "leader"
    t.boolean  "administrator",   :default => false, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "hashed_password"
  end

  add_index "employees", ["department_id"], :name => "index_employees_on_department_id"
  add_index "employees", ["state_id"], :name => "index_employees_on_state_id"

  create_table "grades", :force => true do |t|
    t.string   "gradename"
    t.integer  "unitpayment"
    t.integer  "unitdemand"
    t.float    "holidayschg"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "jobgroups", :force => true do |t|
    t.string   "jgname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobitems", :force => true do |t|
    t.string   "jobname"
    t.integer  "jobgroup_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "jobitems", ["jobgroup_id"], :name => "index_jobitems_on_jobgroup_id"

  create_table "jobplaces", :force => true do |t|
    t.string   "jobplacename"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "prjname"
    t.integer  "client_id"
    t.integer  "splittime_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"
  add_index "projects", ["splittime_id"], :name => "index_projects_on_splittime_id"

  create_table "splittimes", :force => true do |t|
    t.string   "timesplitmode"
    t.datetime "splittime1"
    t.datetime "splittime2"
    t.datetime "splittime3"
    t.datetime "splittime4"
    t.datetime "splittime5"
    t.datetime "splittime6"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "stname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "workreports", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.integer  "jobplace_id"
    t.integer  "jobitem_id"
    t.date     "workdate"
    t.datetime "timefrom"
    t.datetime "timeto"
    t.integer  "addcomment_id"
    t.integer  "grade_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "workreports", ["addcomment_id"], :name => "index_workreports_on_addcomment_id"
  add_index "workreports", ["employee_id"], :name => "index_workreports_on_employee_id"
  add_index "workreports", ["grade_id"], :name => "index_workreports_on_grade_id"
  add_index "workreports", ["jobitem_id"], :name => "index_workreports_on_jobitem_id"
  add_index "workreports", ["jobplace_id"], :name => "index_workreports_on_jobplace_id"
  add_index "workreports", ["project_id"], :name => "index_workreports_on_project_id"

end
