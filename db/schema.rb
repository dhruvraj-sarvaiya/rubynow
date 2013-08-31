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

ActiveRecord::Schema.define(:version => 20130829083340) do

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobpostdetails", :force => true do |t|
    t.string   "company"
    t.string   "company_url"
    t.string   "description"
    t.integer  "type_of_position"
    t.integer  "work_hours"
    t.string   "how_to_apply"
    t.integer  "jobpost_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "jobposts", :force => true do |t|
    t.string   "post_title"
    t.string   "city_state"
    t.integer  "country_id"
    t.string   "referrer_code"
    t.integer  "user_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "post_type",               :default => 1
    t.boolean  "is_full_telecommute_job", :default => false
  end

  create_table "line_items", :force => true do |t|
    t.decimal  "unit_price"
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_billing_infos", :force => true do |t|
    t.integer  "payment_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "add_1"
    t.string   "add_2"
    t.string   "state"
    t.integer  "country_id"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "status"
    t.float    "amount"
    t.string   "transaction_number"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.decimal  "price"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "usermemberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "payment_id"
    t.integer  "post_type"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
