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

ActiveRecord::Schema.define(:version => 20141214220449) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.string  "name",          :limit => 50,                           :null => false
    t.string  "swf",           :limit => 40,                           :null => false
    t.text    "hints_xml",                                             :null => false
    t.string  "help",                                                  :null => false
    t.text    "youtube_embed",                                         :null => false
    t.boolean "convertable",                 :default => false,        :null => false
    t.string  "game_type",                   :default => "OneToOne",   :null => false
    t.text    "node_options"
    t.string  "category",                    :default => "Unscramble"
    t.string  "description"
    t.string  "video_link"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "encrypted_password",     :limit => 128,                :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "audio_clips", :force => true do |t|
    t.integer  "user_id",             :null => false
    t.integer  "used_in_games_tally"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "available_games", :force => true do |t|
    t.integer "game_id",   :default => 0,     :null => false
    t.integer "user_id",   :default => 0,     :null => false
    t.integer "course_id", :default => 0,     :null => false
    t.integer "ordering",  :default => 0,     :null => false
    t.boolean "hidden",    :default => false, :null => false
  end

  create_table "available_posts", :force => true do |t|
    t.integer "post_id",   :null => false
    t.integer "user_id",   :null => false
    t.integer "course_id", :null => false
    t.integer "ordering",  :null => false
    t.boolean "hidden",    :null => false
  end

  create_table "available_word_lists", :force => true do |t|
    t.integer "word_list_id", :default => 0, :null => false
    t.integer "user_id",      :default => 0, :null => false
    t.integer "course_id",    :default => 0, :null => false
    t.integer "order",                       :null => false
    t.boolean "hidden",                      :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "audio_id"
    t.text     "content"
    t.text     "teacher_note"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "available_post_id"
    t.integer  "rating",            :default => 0
  end

  create_table "conference_signups", :force => true do |t|
    t.string   "name",       :limit => 55, :null => false
    t.string   "school",     :limit => 55, :null => false
    t.string   "email",      :limit => 50, :null => false
    t.string   "conference", :limit => 25, :null => false
    t.datetime "date_added",               :null => false
  end

  create_table "course_registrations", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "course_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer "user_id",        :default => 0,     :null => false
    t.string  "name",                              :null => false
    t.integer "grade",          :default => 0,     :null => false
    t.boolean "login_required", :default => false, :null => false
    t.string  "code"
    t.integer "ordering"
    t.string  "guid"
    t.boolean "archived",       :default => false
  end

  create_table "demos", :force => true do |t|
    t.integer "game_id",                   :default => 0, :null => false
    t.string  "category",    :limit => 50,                :null => false
    t.integer "language_id"
    t.integer "activity_id"
  end

  create_table "discounts", :force => true do |t|
    t.integer  "percent",                    :default => 0, :null => false
    t.integer  "single_cost",                :default => 0, :null => false
    t.integer  "school_cost",                :default => 0, :null => false
    t.string   "email_msg",                                 :null => false
    t.string   "target_group", :limit => 25,                :null => false
    t.string   "code",         :limit => 25,                :null => false
    t.datetime "expiration"
  end

  create_table "examples", :force => true do |t|
    t.integer  "language_id"
    t.integer  "activity_id"
    t.boolean  "default"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "node_key_name"
    t.string   "node_value"
    t.string   "input_description"
    t.string   "hint"
  end

  add_index "examples", ["activity_id"], :name => "index_examples_on_activity_id"
  add_index "examples", ["default"], :name => "index_examples_on_default"
  add_index "examples", ["language_id"], :name => "index_examples_on_language_id"

  create_table "feed_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "browser"
    t.string   "ip_address"
    t.string   "controller"
    t.string   "action"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sourceable_type"
    t.integer  "sourceable_id"
  end

  create_table "games", :force => true do |t|
    t.integer  "template_id",     :default => 0,     :null => false
    t.text     "xml",                                :null => false
    t.text     "description",                        :null => false
    t.text     "audio_ids"
    t.integer  "activity_id",     :default => 0,     :null => false
    t.integer  "language_id",     :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id",   :default => 0,     :null => false
    t.integer  "updated_by_id",   :default => 0,     :null => false
    t.boolean  "getting_started", :default => false, :null => false
  end

  add_index "games", ["getting_started"], :name => "index_games_on_getting_started"

  create_table "games_keywords", :primary_key => "game_keyword_id", :force => true do |t|
    t.integer "game_id", :default => 0, :null => false
    t.string  "keyword",                :null => false
  end

  create_table "games_word_lists", :force => true do |t|
    t.integer "word_list_id", :default => 0, :null => false
    t.integer "game_id",      :default => 0, :null => false
  end

  create_table "high_scores", :force => true do |t|
    t.string   "score",             :null => false
    t.datetime "submitted_at",      :null => false
    t.integer  "user_id",           :null => false
    t.string   "user_ip_address",   :null => false
    t.integer  "available_game_id"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  add_index "images", ["user_id"], :name => "index_images_on_user_id"

  create_table "languages", :force => true do |t|
    t.string "name",               :limit => 60, :null => false
    t.string "special_characters",               :null => false
  end

  create_table "media_categories", :force => true do |t|
    t.string  "name",        :limit => 50,                :null => false
    t.integer "media_count",               :default => 0, :null => false
  end

  create_table "media_keywords", :force => true do |t|
    t.integer "media_id",               :null => false
    t.string  "name",     :limit => 50, :null => false
  end

  add_index "media_keywords", ["name"], :name => "keyword"

  create_table "media_types", :force => true do |t|
    t.string "ext", :limit => 5, :null => false
  end

  create_table "medias", :force => true do |t|
    t.string   "name",               :limit => 50,                     :null => false
    t.string   "descrip",            :limit => 75,                     :null => false
    t.string   "path",               :limit => 120,                    :null => false
    t.integer  "media_type_id"
    t.integer  "media_category_id",                                    :null => false
    t.boolean  "published",                         :default => false, :null => false
    t.boolean  "pending",                           :default => false, :null => false
    t.string   "assigned_to"
    t.text     "notes",                                                :null => false
    t.integer  "used_count",                        :default => 0,     :null => false
    t.datetime "date_added"
    t.string   "fla_file_name"
    t.string   "fla_content_type"
    t.integer  "fla_file_size"
    t.datetime "fla_updated_at"
    t.string   "swf_file_name"
    t.string   "swf_content_type"
    t.integer  "swf_file_size"
    t.datetime "swf_updated_at"
    t.string   "image_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "medias", ["name", "descrip"], :name => "name"

  create_table "news", :force => true do |t|
    t.string   "summary",                  :null => false
    t.string   "headline",   :limit => 75, :null => false
    t.text     "content",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "audio_id"
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "shared",     :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name",                                         :null => false
    t.string   "address",    :limit => 200,                    :null => false
    t.string   "city",       :limit => 35,                     :null => false
    t.integer  "state_id",                  :default => 0,     :null => false
    t.string   "zip",        :limit => 10,                     :null => false
    t.boolean  "enabled",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expired_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "states", :force => true do |t|
    t.string  "name", :limit => 30,                    :null => false
    t.string  "abbr", :limit => 15,                    :null => false
    t.boolean "intl",               :default => false, :null => false
  end

  create_table "study_histories", :force => true do |t|
    t.integer  "user_id",                :null => false
    t.string   "study_type",             :null => false
    t.string   "user_ip_address",        :null => false
    t.datetime "submitted_at",           :null => false
    t.integer  "available_word_list_id"
  end

  create_table "subscription_plans", :force => true do |t|
    t.string  "name",         :limit => 100,                                :null => false
    t.integer "max_teachers",                                               :null => false
    t.decimal "cost",                        :precision => 10, :scale => 0, :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscription_plan_id", :null => false
    t.integer  "pin"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.datetime "expired_at",           :null => false
  end

  create_table "templates", :force => true do |t|
    t.integer "admin",       :default => 0, :null => false
    t.integer "activity_id", :default => 0, :null => false
    t.integer "language_id", :default => 0, :null => false
    t.integer "user_id",     :default => 0, :null => false
    t.string  "name"
    t.text    "description"
    t.text    "xml",                        :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.string "email",    :null => false
    t.string "password", :null => false
  end

  create_table "users", :force => true do |t|
    t.boolean  "enabled",                            :default => true,  :null => false
    t.string   "email",               :limit => 45,                     :null => false
    t.string   "crypted_password",                                      :null => false
    t.string   "password_salt",                                         :null => false
    t.string   "persistence_token",                                     :null => false
    t.string   "perishable_token",                                      :null => false
    t.string   "first_name",          :limit => 50,                     :null => false
    t.string   "last_name",           :limit => 50,                     :null => false
    t.string   "display_name",        :limit => 100,                    :null => false
    t.integer  "school_id",                          :default => 0,     :null => false
    t.string   "role",                :limit => 50,  :default => "0",   :null => false
    t.integer  "subscription_id",                    :default => 0,     :null => false
    t.integer  "discount_id",                        :default => 0,     :null => false
    t.boolean  "email_active",                       :default => true,  :null => false
    t.boolean  "receive_newsletter",                 :default => false, :null => false
    t.integer  "default_language_id",                :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "last_login_at"
    t.integer  "login_count",                        :default => 0,     :null => false
    t.string   "last_login_ip",       :limit => 40
    t.datetime "current_login_at"
    t.string   "current_login_ip"
    t.datetime "last_request_at"
  end

  create_table "word_lists", :force => true do |t|
    t.text     "xml"
    t.text     "description",                  :null => false
    t.integer  "language_id",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id", :default => 0, :null => false
    t.integer  "updated_by_id", :default => 0, :null => false
  end

  create_table "word_lists_keywords", :force => true do |t|
    t.integer "word_list_id",               :default => 0, :null => false
    t.string  "keyword",      :limit => 40,                :null => false
  end

end
