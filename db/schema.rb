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

ActiveRecord::Schema.define(version: 20160322203428) do

  create_table "histories", force: :cascade do |t|
    t.string   "symbol"
    t.date     "date"
    t.decimal  "open"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "close"
    t.integer  "volume"
    t.decimal  "adj_close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "stock_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "portfolios", ["stock_id"], name: "index_portfolios_on_stock_id"
  add_index "portfolios", ["user_id"], name: "index_portfolios_on_user_id"

  create_table "portfolios_stocks", force: :cascade do |t|
    t.integer  "portfolio_id"
    t.integer  "stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "portfolios_stocks", ["portfolio_id", "stock_id"], name: "index_portfolios_stocks_on_portfolio_id_and_stock_id", unique: true
  add_index "portfolios_stocks", ["portfolio_id"], name: "index_portfolios_stocks_on_portfolio_id"
  add_index "portfolios_stocks", ["stock_id"], name: "index_portfolios_stocks_on_stock_id"

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "change"
    t.decimal  "volume"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "averagedailyvolume"
    t.decimal  "dayslow"
    t.decimal  "dayshigh"
    t.decimal  "yearlow"
    t.decimal  "yearhigh"
    t.string   "marketcapitalization"
    t.decimal  "lasttradepriceonly"
    t.string   "daysrange"
    t.string   "stockexchange"
    t.string   "ticks"
    t.string   "bounce"
    t.string   "lasttradedate"
    t.string   "lasttradetime"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
