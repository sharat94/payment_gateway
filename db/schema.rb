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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170819054450) do

  create_table "payments", force: :cascade do |t|
    t.string   "bank_ifsc_code"
    t.integer  "bank_account_number"
    t.integer  "amount"
    t.string   "merchant_transaction_ref"
    t.date     "transaction_date"
    t.string   "payment_gateway_merchant_reference"
    t.string   "payload_with_sha"
    t.string   "payload_to_pg"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

end
