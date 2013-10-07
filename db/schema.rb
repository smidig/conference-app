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

ActiveRecord::Schema.define(:version => 20131007192646) do

  create_table "orders", :force => true do |t|
    t.string   "comment"
    t.boolean  "completed"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "owner_user_id"
  end

  create_table "payments", :force => true do |t|
    t.integer  "price"
    t.integer  "paid_amount"
    t.boolean  "completed"
    t.datetime "completed_at"
    t.text     "paypal_params"
    t.string   "paypal_tx_id"
    t.string   "paypal_tx_type"
    t.string   "paypal_currency"
    t.string   "paypal_status"
    t.string   "paypal_payer_email"
    t.string   "manual_company_name"
    t.string   "manual_company_email"
    t.string   "manual_contact_person"
    t.string   "manual_street_address"
    t.string   "manual_post_code"
    t.boolean  "manual_invoice_sent"
    t.integer  "order_id"
    t.string   "type"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "invoice_id"
    t.string   "manual_invoice_id"
    t.string   "manual_city"
    t.integer  "manual_organization_number"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "details"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "color"
  end

  create_table "roomslots", :force => true do |t|
    t.integer  "timeslot_id"
    t.integer  "room_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
    t.text     "description"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "imageUrl"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "talk_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talk_comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "talk_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talk_types", :force => true do |t|
    t.string   "name"
    t.integer  "duration"
    t.boolean  "visible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talks", :force => true do |t|
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "title"
    t.text     "description"
    t.integer  "talk_type_id"
    t.integer  "talk_category_id"
    t.string   "presentation_file_name"
    t.string   "presentation_content_type"
    t.integer  "presentation_file_size"
    t.datetime "presentation_updated_at"
    t.string   "status",                    :default => "pending"
    t.integer  "user_id"
    t.integer  "roomslot_id"
    t.integer  "roomslot_priority"
  end

  add_index "talks", ["user_id"], :name => "index_talks_on_user_id"

  create_table "talks_users", :id => false, :force => true do |t|
    t.integer "talk_id"
    t.integer "user_id"
  end

  create_table "tickets", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.boolean  "active"
    t.boolean  "visible"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "ticket_type"
  end

  create_table "timeslots", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                   :default => "", :null => false
    t.string   "encrypted_password",      :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "admin"
    t.string   "name"
    t.string   "tlf"
    t.string   "company"
    t.boolean  "accepted_optional_email"
    t.string   "twitter"
    t.string   "allergies"
    t.integer  "ticket_id"
    t.integer  "order_id"
    t.boolean  "completed"
    t.boolean  "includes_dinner"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
