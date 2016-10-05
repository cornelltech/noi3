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

ActiveRecord::Schema.define(version: 20161003034905) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_users", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "user_id",     null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "conference_code", default: ""
    t.string   "name",            default: ""
    t.string   "logo_path",       default: ""
    t.datetime "date",            default: '2016-10-05 03:30:14'
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "industries_projects", id: false, force: :cascade do |t|
    t.integer "industry_id", null: false
    t.integer "project_id",  null: false
  end

  create_table "industries_users", id: false, force: :cascade do |t|
    t.integer "industry_id", null: false
    t.integer "user_id",     null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "languages_projects", id: false, force: :cascade do |t|
    t.integer "language_id", null: false
    t.integer "project_id",  null: false
  end

  create_table "languages_users", id: false, force: :cascade do |t|
    t.integer "language_id", null: false
    t.integer "user_id",     null: false
  end

  create_table "learnables", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_learnables_on_skill_id"
    t.index ["user_id"], name: "index_learnables_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title",       default: ""
    t.string   "description", default: ""
    t.string   "url"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
  end

  create_table "projects_skill_areas", id: false, force: :cascade do |t|
    t.integer "project_id",    null: false
    t.integer "skill_area_id", null: false
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "skill_areas", force: :cascade do |t|
    t.string   "name",        default: ""
    t.string   "long_name",   default: ""
    t.integer  "category_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["category_id"], name: "index_skill_areas_on_category_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string   "short_name",    default: ""
    t.string   "description",   default: ""
    t.integer  "category_id"
    t.integer  "skill_area_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["category_id"], name: "index_skills_on_category_id"
    t.index ["skill_area_id"], name: "index_skills_on_skill_area_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_surveys_on_category_id"
  end

  create_table "teachables", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_teachables_on_skill_id"
    t.index ["user_id"], name: "index_teachables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "picture_path",           default: ""
    t.string   "first_name",             default: ""
    t.string   "last_name",              default: ""
    t.string   "position",               default: ""
    t.string   "organization",           default: ""
    t.string   "organization_type",      default: ""
    t.string   "city",                   default: ""
    t.boolean  "admin",                  default: false, null: false
    t.string   "username"
    t.string   "country_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
