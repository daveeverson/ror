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

ActiveRecord::Schema.define(:version => 20191023031345) do

  create_table "daily_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active_flag",  :default => true
    t.boolean  "media_flag"
    t.boolean  "request_flag"
  end

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "work_phone"
    t.string   "email_addr"
    t.string   "unit_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "seid"
  end

  create_table "geometry_columns", :id => false, :force => true do |t|
    t.string  "f_table_catalog",   :limit => 256, :null => false
    t.string  "f_table_schema",    :limit => 256, :null => false
    t.string  "f_table_name",      :limit => 256, :null => false
    t.string  "f_geometry_column", :limit => 256, :null => false
    t.integer "coord_dimension",                  :null => false
    t.integer "srid",                             :null => false
    t.string  "type",              :limit => 30,  :null => false
  end

  create_table "legislative_contact_units", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legislative_contacts", :force => true do |t|
    t.integer  "author_id"
    t.string   "topic"
    t.string   "tribal_contact_first_name"
    t.string   "tribal_contact_last_name"
    t.string   "tribal_contact_phone_nbr"
    t.string   "staff_first_name"
    t.string   "staff_last_name"
    t.string   "staff_email"
    t.date     "contact_date"
    t.string   "notes",                     :limit => 10000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "submitted_flag",                             :default => false
    t.integer  "unit_id"
    t.string   "tribal_name"
  end

  create_table "media_contact_attachments", :force => true do |t|
    t.integer "media_contact_id"
    t.string  "attachment_file_name"
    t.string  "attachment_content_type"
    t.integer "attachment_file_size"
    t.string  "attachment_type"
  end

  create_table "media_contact_units", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_contacts", :force => true do |t|
    t.integer  "author_id"
    t.string   "topic"
    t.string   "media_outlet"
    t.string   "reporter_first_name"
    t.string   "reporter_last_name"
    t.string   "reporter_phone_nbr"
    t.string   "staff_first_name"
    t.string   "staff_last_name"
    t.string   "staff_email"
    t.date     "contact_date"
    t.string   "notes",               :limit => 10000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "submitted_flag",                       :default => false
    t.integer  "unit_id"
    t.integer  "outlet_type_id"
    t.date     "publication_date"
  end

  create_table "outlet_types", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outlets", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.integer  "outlet_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_attachments", :force => true do |t|
    t.integer "request_id"
    t.string  "attachment_file_name"
    t.string  "attachment_content_type"
    t.integer "attachment_file_size"
    t.string  "attachment_type"
  end

  create_table "request_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "author_id"
    t.string   "description",          :limit => 2000
    t.date     "request_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_type_id"
    t.string   "public_data"
    t.boolean  "unit_contacted"
    t.string   "status"
    t.decimal  "copy_fee_amt",                         :precision => 10, :scale => 2
    t.string   "documents_attached"
    t.date     "status_date"
    t.string   "statute"
    t.integer  "unit_designee_id"
    t.string   "response_lead"
    t.boolean  "submitted_flag",                                                      :default => false
    t.string   "requestor_first_name"
    t.string   "requestor_last_name"
    t.string   "requestor_org"
    t.string   "requestor_phone"
    t.string   "requestor_email"
    t.string   "topic"
    t.integer  "last_editor_id"
    t.string   "response",             :limit => 2000
  end

  create_table "requests_units", :id => false, :force => true do |t|
    t.integer "request_id"
    t.integer "unit_id"
  end

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics_units", :id => false, :force => true do |t|
    t.integer "topic_id"
    t.integer "unit_id"
  end

  create_table "unit_designees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active_flag"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
