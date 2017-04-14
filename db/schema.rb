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

ActiveRecord::Schema.define(:version => 20170414031214) do

  create_table "cities", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "pinyin"
    t.integer  "province_id", :default => 9, :null => false
    t.integer  "sort",        :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "cities", ["province_id"], :name => "index_cities_on_province_id"

  create_table "departments", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "description",                :null => false
    t.integer  "sort",        :default => 1, :null => false
    t.integer  "status",      :default => 1, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "districts", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "pinyin"
    t.integer  "city_id",    :default => 73, :null => false
    t.integer  "sort",       :default => 0,  :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"

  create_table "permissions", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "description"
    t.integer  "status",      :default => 1, :null => false
    t.integer  "sort",        :default => 1, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name",                                                                :null => false
    t.string   "no",                                                                  :null => false
    t.decimal  "price",               :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.datetime "expiration_date",                                                     :null => false
    t.integer  "produced_date",                                                       :null => false
    t.string   "store_condition",                                                     :null => false
    t.string   "feature"
    t.string   "category"
    t.string   "transport_condition"
    t.integer  "status",                                             :default => 1,   :null => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  create_table "provinces", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "pinyin"
    t.integer  "sort",       :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "role_permission_maps", :force => true do |t|
    t.integer  "permission_id", :null => false
    t.integer  "role_id",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name",                       :null => false
    t.integer  "sort",        :default => 1, :null => false
    t.string   "description",                :null => false
    t.integer  "status",      :default => 1, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "staff_transfers", :force => true do |t|
    t.integer  "staff_id",                            :null => false
    t.integer  "is_admin",             :default => 0, :null => false
    t.integer  "is_department",        :default => 0, :null => false
    t.integer  "is_warehouse",         :default => 0, :null => false
    t.integer  "before_department_id"
    t.integer  "department_id"
    t.integer  "before_warehouse_id"
    t.integer  "warehouse_id"
    t.string   "description"
    t.integer  "operator_id",                         :null => false
    t.string   "operator_type",                       :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "role_id"
  end

  create_table "staffs", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "no",                                   :null => false
    t.string   "mobile",                               :null => false
    t.integer  "gender",              :default => 1,   :null => false
    t.integer  "years"
    t.integer  "months"
    t.integer  "days"
    t.integer  "age"
    t.string   "qq"
    t.string   "weixin"
    t.integer  "province_id",         :default => 9,   :null => false
    t.integer  "city_id",             :default => 73,  :null => false
    t.integer  "district_id",         :default => 702, :null => false
    t.string   "address",                              :null => false
    t.string   "email"
    t.string   "description"
    t.integer  "sign_in_count",       :default => 0,   :null => false
    t.datetime "current_sign_in_at"
    t.datetime "current_sign_out_at"
    t.string   "current_sign_in_ip"
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.integer  "department_id"
    t.integer  "warehouse_id"
    t.integer  "role_id",                              :null => false
    t.integer  "status",              :default => 1,   :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "system_records", :force => true do |t|
    t.string   "operatorable_id",   :null => false
    t.string   "operatorable_type", :null => false
    t.string   "action",            :null => false
    t.integer  "operator_id",       :null => false
    t.string   "operator_type",     :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "warehouse_products", :force => true do |t|
    t.integer  "product_id",                                                   :null => false
    t.integer  "warehouse_id",                                                 :null => false
    t.integer  "qty",                                         :default => 0,   :null => false
    t.decimal  "price",        :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "warehouse_records", :force => true do |t|
    t.integer  "product_id",                                                   :null => false
    t.integer  "warehouse_id",                                                 :null => false
    t.integer  "staff_id",                                                     :null => false
    t.integer  "is_admin",                                    :default => 0,   :null => false
    t.integer  "qty",                                         :default => 0,   :null => false
    t.decimal  "price",        :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.integer  "record_type",                                 :default => 1,   :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "warehouses", :force => true do |t|
    t.string   "name",                         :null => false
    t.integer  "size",        :default => 1,   :null => false
    t.integer  "scale"
    t.integer  "province_id", :default => 9,   :null => false
    t.integer  "city_id",     :default => 73,  :null => false
    t.integer  "district_id", :default => 702, :null => false
    t.string   "address",                      :null => false
    t.string   "description"
    t.integer  "status",      :default => 1,   :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end
