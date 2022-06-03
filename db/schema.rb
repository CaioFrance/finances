# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_03_052355) do
  create_table "log_transactions", force: :cascade do |t|
    t.date "transaction_date", null: false
    t.datetime "import_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "origin_bank", null: false
    t.string "origin_branch", null: false
    t.string "origin_account", null: false
    t.string "target_bank", null: false
    t.string "target_branch", null: false
    t.string "target_account", null: false
    t.string "value_transaction", null: false
    t.datetime "datetime_transaction", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "log_transactions_id", null: false
    t.index ["log_transactions_id"], name: "index_transactions_on_log_transactions_id"
  end

  add_foreign_key "transactions", "log_transactions", column: "log_transactions_id"
end
