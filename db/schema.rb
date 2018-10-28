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

ActiveRecord::Schema.define(version: 2018_10_20_221215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.boolean "capital"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "trade_name"
    t.string "cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "company_addresses", force: :cascade do |t|
    t.string "street_address"
    t.integer "number"
    t.integer "city_id"
    t.string "zip_code"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "company_contacts", force: :cascade do |t|
    t.string "personal_title"
    t.string "name"
    t.string "occupation"
    t.string "sector"
    t.string "email"
    t.integer "company_id"
    t.boolean "send_document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "document_types", force: :cascade do |t|
    t.string "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer "number"
    t.integer "year"
    t.text "text"
    t.datetime "date"
    t.integer "subject_id"
    t.integer "company_contact_id"
    t.integer "responsible_id"
    t.string "autentication"
    t.datetime "issuance_date"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "description"
    t.text "text"
    t.integer "document_type_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "cities", "states", name: "fk_cities_states_id"
  add_foreign_key "company_addresses", "cities", name: "fk_company_addresses_cities_id"
  add_foreign_key "company_addresses", "companies", name: "fk_company_addresses_companies_id"
  add_foreign_key "company_contacts", "companies", name: "fk_company_contacts_companies_id"
  add_foreign_key "documents", "company_contacts", column: "responsible_id", name: "fk_documents_responsible_id_company_contacts_id"
  add_foreign_key "documents", "company_contacts", name: "fk_documents_company_contacts_id"
  add_foreign_key "states", "countries", name: "fk_states_countries_id"
  add_foreign_key "subjects", "document_types", name: "fk_subjects_document_types_id"
end
