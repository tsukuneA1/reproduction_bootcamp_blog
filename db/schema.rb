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

ActiveRecord::Schema[8.0].define(version: 2025_05_11_083844) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "blogs", id: :string, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "author_id", null: false
    t.string "title"
    t.text "content"
    t.boolean "is_published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blogs_on_author_id"
  end

  create_table "bookmarks", id: :string, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "blog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "blog_id"], name: "index_bookmarks_on_user_id_and_blog_id", unique: true
  end

  create_table "relationships", id: :string, force: :cascade do |t|
    t.string "followee_id", null: false
    t.string "follower_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id", "follower_id"], name: "index_relationships_on_followee_id_and_follower_id", unique: true
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
