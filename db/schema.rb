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

ActiveRecord::Schema.define(version: 20160502124444) do

  create_table "admins", force: true do |t|
    t.string   "email",              limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "agreements", force: true do |t|
    t.integer  "plan_id",               limit: 4
    t.integer  "user_id",               limit: 4
    t.string   "paypal_token",          limit: 255
    t.text     "approval_url",          limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "end_at"
    t.string   "paypal_id",             limit: 255
    t.string   "paypal_payment_status", limit: 255
    t.boolean  "discounted",            limit: 1,        default: false
  end

  add_index "agreements", ["plan_id"], name: "fk_rails_3c62cb8baf", using: :btree
  add_index "agreements", ["user_id"], name: "fk_rails_b79f8feff5", using: :btree

  create_table "atmospheres", force: true do |t|
    t.string  "label",        limit: 255
    t.integer "opuses_count", limit: 4,     default: 0, null: false
    t.string  "color",        limit: 255
    t.text    "svg_icon",     limit: 65535
  end

  create_table "bank_details", force: true do |t|
    t.integer "user_id",         limit: 4
    t.string  "iban",            limit: 255
    t.string  "bic",             limit: 255
    t.string  "owner_firstname", limit: 255
    t.string  "owner_lastname",  limit: 255
    t.text    "owner_address",   limit: 16777215
  end

  create_table "carts", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["user_id"], name: "fk_rails_de41e43301", using: :btree

  create_table "chapters", force: true do |t|
    t.integer  "opus_id",          limit: 4
    t.string   "title",            limit: 255
    t.text     "content",          limit: 16777215
    t.string   "font_color",       limit: 255
    t.string   "background_image", limit: 255
    t.integer  "position",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapters", ["opus_id"], name: "fk_rails_8531548da1", using: :btree

  create_table "collaboration_types", force: true do |t|
    t.string "label", limit: 255
  end

  create_table "collaborations", force: true do |t|
    t.integer "user_id",               limit: 4
    t.integer "opus_id",               limit: 4
    t.integer "collaboration_type_id", limit: 4
  end

  add_index "collaborations", ["collaboration_type_id"], name: "fk_rails_a28682fef3", using: :btree
  add_index "collaborations", ["opus_id"], name: "fk_rails_ed1a95c4a5", using: :btree
  add_index "collaborations", ["user_id"], name: "fk_rails_c500cb22e6", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "opus_id",    limit: 4
    t.text     "content",    limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["opus_id"], name: "fk_rails_40c98b56ce", using: :btree

  create_table "discount_codes", force: true do |t|
    t.string   "denomination",   limit: 255
    t.string   "value",          limit: 255
    t.integer  "cycles",         limit: 4
    t.datetime "validity_limit"
  end

  add_index "discount_codes", ["value"], name: "index_discount_codes_on_value", unique: true, using: :btree

  create_table "feellists", force: true do |t|
    t.integer "user_id", limit: 4
    t.string  "name",    limit: 255
    t.boolean "default", limit: 1,   default: false
  end

  add_index "feellists", ["user_id"], name: "fk_rails_5580c0f0b3", using: :btree

  create_table "items", force: true do |t|
    t.integer  "opus_id",       limit: 4
    t.decimal  "price",                     precision: 8, scale: 2
    t.string   "title",         limit: 255
    t.integer  "itemable_id",   limit: 4
    t.string   "itemable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["opus_id"], name: "fk_rails_444e412494", using: :btree

  create_table "keyword_opuses", force: true do |t|
    t.integer "keyword_id", limit: 4
    t.integer "opus_id",    limit: 4
  end

  add_index "keyword_opuses", ["keyword_id"], name: "fk_rails_54d7a1e823", using: :btree
  add_index "keyword_opuses", ["opus_id"], name: "fk_rails_4eb474abfa", using: :btree

  create_table "keywords", force: true do |t|
    t.string  "label",        limit: 255
    t.integer "opuses_count", limit: 4,   default: 0, null: false
  end

  create_table "languages", force: true do |t|
    t.string  "label",        limit: 255
    t.integer "opuses_count", limit: 4,   default: 0, null: false
  end

  create_table "library_entries", force: true do |t|
    t.integer "opus_id",     limit: 4
    t.integer "feellist_id", limit: 4
  end

  add_index "library_entries", ["feellist_id"], name: "fk_rails_fa1f1e7c7d", using: :btree
  add_index "library_entries", ["opus_id"], name: "fk_rails_d94b3e1f33", using: :btree

  create_table "likes", force: true do |t|
    t.integer "opus_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "likes", ["opus_id", "user_id"], name: "index_likes_on_opus_id_and_user_id", unique: true, using: :btree

  create_table "opuses", force: true do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "atmosphere_id",   limit: 4
    t.integer  "play_time_id",    limit: 4
    t.decimal  "price",                            precision: 8, scale: 2
    t.string   "title",           limit: 255
    t.text     "abstract",        limit: 16777215
    t.string   "font_color",      limit: 255
    t.string   "font_family",     limit: 255
    t.boolean  "atf_experience",  limit: 1,                                default: false
    t.boolean  "published",       limit: 1,                                default: false
    t.string   "cover",           limit: 255
    t.integer  "likes_count",     limit: 4,                                default: 0
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id",     limit: 4
    t.string   "isbn",            limit: 255
    t.boolean  "selected",        limit: 1,                                default: false
    t.datetime "selected_at"
    t.boolean  "flagged",         limit: 1,                                default: false
    t.string   "author_override", limit: 255
    t.text     "keywords_list",   limit: 16777215
  end

  add_index "opuses", ["atmosphere_id"], name: "fk_rails_ab4bf748d7", using: :btree
  add_index "opuses", ["language_id"], name: "fk_rails_28064901b7", using: :btree
  add_index "opuses", ["play_time_id"], name: "fk_rails_2df748a270", using: :btree
  add_index "opuses", ["user_id"], name: "fk_rails_715c9c006e", using: :btree

  create_table "opuses_logs", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "opus_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opuses_logs", ["opus_id"], name: "fk_rails_68571c24ce", using: :btree
  add_index "opuses_logs", ["user_id"], name: "fk_rails_abb58e7c56", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 255
  end

  add_index "orders", ["user_id"], name: "fk_rails_3812ee799c", using: :btree

  create_table "plans", force: true do |t|
    t.string  "name",        limit: 255
    t.text    "description", limit: 16777215
    t.integer "cycles",      limit: 4
    t.decimal "price",                        precision: 8, scale: 2
    t.string  "paypal_id",   limit: 255
    t.text    "paypal_link", limit: 16777215
    t.string  "state",       limit: 255
    t.boolean "visible",     limit: 1
    t.string  "fixed_id",    limit: 255
  end

  add_index "plans", ["fixed_id"], name: "index_plans_on_fixed_id", unique: true, using: :btree

  create_table "play_times", force: true do |t|
    t.string  "label",        limit: 255
    t.integer "opuses_count", limit: 4,   default: 0, null: false
  end

  create_table "slider_entries", force: true do |t|
    t.integer "chapter_id", limit: 4
    t.string  "file",       limit: 255
    t.integer "position",   limit: 4
  end

  add_index "slider_entries", ["chapter_id"], name: "fk_rails_631824ba78", using: :btree

  create_table "sounds", force: true do |t|
    t.string  "file",           limit: 255
    t.string  "type",           limit: 255
    t.string  "title",          limit: 255
    t.integer "soundable_id",   limit: 4
    t.string  "soundable_type", limit: 255
  end

  create_table "user_opuses", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "opus_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_opuses", ["opus_id"], name: "index_user_opuses_on_opus_id", using: :btree
  add_index "user_opuses", ["user_id"], name: "index_user_opuses_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 255,      default: "",    null: false
    t.string   "encrypted_password",     limit: 255,      default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,        default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.string   "phone",                  limit: 255
    t.text     "address",                limit: 16777215
    t.boolean  "artist",                 limit: 1,        default: false
    t.string   "nickname",               limit: 255
    t.text     "resume",                 limit: 16777215
    t.string   "avatar",                 limit: 255
    t.integer  "opuses_count",           limit: 4,        default: 0,     null: false
    t.string   "title",                  limit: 255
    t.datetime "first_published_opus"
    t.boolean  "accepts_contact",        limit: 1,        default: false
    t.boolean  "accepts_newsletter",     limit: 1,        default: false
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "agreements", "plans", on_delete: :nullify
  add_foreign_key "agreements", "users", on_delete: :cascade
  add_foreign_key "carts", "users", on_delete: :nullify
  add_foreign_key "chapters", "opuses", on_delete: :cascade
  add_foreign_key "collaborations", "collaboration_types", on_delete: :nullify
  add_foreign_key "collaborations", "opuses", on_delete: :cascade
  add_foreign_key "collaborations", "users", on_delete: :cascade
  add_foreign_key "comments", "opuses", on_delete: :cascade
  add_foreign_key "feellists", "users", on_delete: :cascade
  add_foreign_key "items", "opuses", on_delete: :cascade
  add_foreign_key "keyword_opuses", "keywords", on_delete: :cascade
  add_foreign_key "keyword_opuses", "opuses", on_delete: :cascade
  add_foreign_key "library_entries", "feellists", on_delete: :nullify
  add_foreign_key "library_entries", "opuses", on_delete: :cascade
  add_foreign_key "likes", "opuses", on_delete: :cascade
  add_foreign_key "opuses", "atmospheres", on_delete: :nullify
  add_foreign_key "opuses", "languages", on_delete: :nullify
  add_foreign_key "opuses", "play_times", on_delete: :nullify
  add_foreign_key "opuses", "users"
  add_foreign_key "opuses", "users", on_delete: :cascade
  add_foreign_key "opuses_logs", "opuses", on_delete: :cascade
  add_foreign_key "opuses_logs", "users", on_delete: :cascade
  add_foreign_key "orders", "users", on_delete: :cascade
  add_foreign_key "slider_entries", "chapters", on_delete: :cascade
  add_foreign_key "user_opuses", "opuses"
  add_foreign_key "user_opuses", "users"
end
