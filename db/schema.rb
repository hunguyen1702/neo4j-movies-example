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

ActiveRecord::Schema.define(version: 20180827064627) do

  create_table "act_in_movies", force: :cascade do |t|
    t.integer  "actor_id",   limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "act_in_movies", ["actor_id"], name: "index_act_in_movies_on_actor_id", using: :btree
  add_index "act_in_movies", ["movie_id"], name: "index_act_in_movies_on_movie_id", using: :btree

  create_table "friend_ships", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "friend_user_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "friend_ships", ["friend_user_id"], name: "index_friend_ships_on_friend_user_id", using: :btree
  add_index "friend_ships", ["user_id"], name: "index_friend_ships_on_user_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "studio",       limit: 255
    t.datetime "release_date"
    t.string   "imdb_id",      limit: 255
    t.integer  "runtime",      limit: 4
    t.text     "description",  limit: 65535
    t.string   "language",     limit: 255
    t.string   "title",        limit: 255
    t.text     "trailer",      limit: 65535
    t.text     "image_url",    limit: 65535
    t.string   "genre",        limit: 255
    t.text     "tag_line",     limit: 65535
    t.text     "homepage",     limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "director_id",  limit: 4
  end

  create_table "people", force: :cascade do |t|
    t.datetime "birthday"
    t.string   "birthplace",  limit: 255
    t.string   "name",        limit: 255
    t.text     "biography",   limit: 65535
    t.string   "profile_img", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "people_person_types", id: false, force: :cascade do |t|
    t.integer "person_id",      limit: 4, null: false
    t.integer "person_type_id", limit: 4, null: false
  end

  add_index "people_person_types", ["person_id", "person_type_id"], name: "index_people_person_types_on_person_id_and_person_type_id", unique: true, using: :btree

  create_table "person_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "person_types", ["name"], name: "index_person_types_on_name", unique: true, using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "comment",    limit: 65535
    t.integer  "star",       limit: 4
  end

  add_index "rates", ["movie_id"], name: "index_rates_on_movie_id", using: :btree
  add_index "rates", ["user_id"], name: "index_rates_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255
    t.string   "name",                   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "act_in_movies", "movies"
  add_foreign_key "friend_ships", "users"
  add_foreign_key "rates", "movies"
  add_foreign_key "rates", "users"
end
