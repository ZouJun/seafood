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

ActiveRecord::Schema.define(:version => 20161023025834) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "password_digest"
    t.string   "mobile"
    t.string   "email"
    t.string   "tel"
    t.string   "address"
    t.integer  "province_id",     :default => 9,   :null => false
    t.integer  "city_id",         :default => 73,  :null => false
    t.integer  "district_id",     :default => 702, :null => false
    t.string   "description"
    t.integer  "status",          :default => 1
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "password_digest"
    t.string   "mobile"
    t.string   "email"
    t.string   "tel"
    t.string   "address"
    t.integer  "proxy_type"
    t.integer  "province_id",     :default => 9,   :null => false
    t.integer  "city_id",         :default => 73,  :null => false
    t.integer  "district_id",     :default => 702, :null => false
    t.string   "description"
    t.integer  "status",          :default => 1
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name",                         :null => false
    t.integer  "sort"
    t.string   "description"
    t.integer  "category_type", :default => 1
    t.integer  "status",        :default => 1
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "star"
    t.string   "description"
    t.integer  "order_id"
    t.integer  "status",      :default => 1
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "dispatchers", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "password_digest"
    t.string   "mobile"
    t.string   "email"
    t.string   "tel"
    t.string   "address"
    t.integer  "province_id",     :default => 9,   :null => false
    t.integer  "city_id",         :default => 73,  :null => false
    t.integer  "district_id",     :default => 702, :null => false
    t.string   "description"
    t.integer  "status",          :default => 1
    t.integer  "agent_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "order_no"
    t.date     "booking_at"
    t.string   "detail"
    t.string   "username"
    t.string   "mobile"
    t.string   "address"
    t.string   "description"
    t.integer  "admin_allocation_type"
    t.integer  "agent_allocation_type"
    t.string   "order_status"
    t.integer  "admin_status",          :default => 1
    t.integer  "agent_status",          :default => 1
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "agent_id"
    t.integer  "dispatcher_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "user_addresses", :force => true do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "address"
    t.boolean  "is_default",  :default => false
    t.string   "description"
    t.integer  "status",      :default => 1
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

end
