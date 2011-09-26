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

ActiveRecord::Schema.define(:version => 20110926180534) do

  create_table "activities", :force => true do |t|
    t.string  "name",          :limit => 50,                    :null => false
    t.string  "swf",           :limit => 40,                    :null => false
    t.text    "hints_xml",                                      :null => false
    t.string  "help",                                           :null => false
    t.text    "youtube_embed",                                  :null => false
    t.boolean "convertable",                 :default => false, :null => false
  end

  create_table "audio_clips", :force => true do |t|
    t.integer  "user_id",             :null => false
    t.integer  "used_in_games_tally", :null => false
    t.integer  "post_id",             :null => false
    t.integer  "comment_id",          :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
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
    t.integer "hidden",    :null => false
  end

  create_table "available_word_lists", :force => true do |t|
    t.integer "word_list_id", :default => 0, :null => false
    t.integer "user_id",      :default => 0, :null => false
    t.integer "course_id",    :default => 0, :null => false
    t.integer "order",                       :null => false
    t.integer "hidden",                      :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id",      :null => false
    t.integer  "user_id",      :null => false
    t.integer  "audio_id"
    t.text     "content"
    t.text     "teacher_note", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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
  end

  create_table "demos", :force => true do |t|
    t.string  "language_id", :limit => 2,                 :null => false
    t.string  "activity_id", :limit => 3,                 :null => false
    t.integer "game_id",                   :default => 0, :null => false
    t.string  "category",    :limit => 50,                :null => false
  end

  create_table "discounts", :force => true do |t|
    t.integer  "percent",      :limit => 1,  :default => 0,  :null => false
    t.integer  "single_cost",  :limit => 1,  :default => 0,  :null => false
    t.integer  "school_cost",  :limit => 1,  :default => 0,  :null => false
    t.string   "email_msg",                  :default => "", :null => false
    t.string   "target_group", :limit => 25, :default => "", :null => false
    t.string   "code",         :limit => 25, :default => "", :null => false
    t.datetime "expiration"
  end

  create_table "games", :force => true do |t|
    t.integer  "template_id",                    :default => 0,     :null => false
    t.text     "xml",                                               :null => false
    t.string   "description",     :limit => 250,                    :null => false
    t.string   "audio_ids",       :limit => 200,                    :null => false
    t.integer  "activity_id",                    :default => 0,     :null => false
    t.integer  "language_id",                    :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id",                  :default => 0,     :null => false
    t.integer  "updated_by_id",                  :default => 0,     :null => false
    t.boolean  "getting_started",                :default => false, :null => false
  end

  add_index "games", ["description"], :name => "game_descrip"
  add_index "games", ["getting_started"], :name => "index_games_on_getting_started"

  create_table "games_keywords", :primary_key => "game_keyword_id", :force => true do |t|
    t.integer "game_id", :default => 0, :null => false
    t.string  "keyword",                :null => false
  end

  add_index "games_keywords", ["keyword"], :name => "keyword"

  create_table "games_word_lists", :force => true do |t|
    t.integer "word_list_id", :default => 0, :null => false
    t.integer "game_id",      :default => 0, :null => false
  end

  create_table "high_scores", :force => true do |t|
    t.string   "score",           :null => false
    t.integer  "game_id",         :null => false
    t.datetime "submitted_at",    :null => false
    t.integer  "user_id",         :null => false
    t.string   "user_ip_address", :null => false
  end

  create_table "languages", :force => true do |t|
    t.string "name",               :limit => 60, :null => false
    t.string "special_characters",               :null => false
  end

  create_table "media_categories", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "media_keywords", :force => true do |t|
    t.integer "media_id",               :null => false
    t.string  "name",     :limit => 50, :null => false
  end

  add_index "media_keywords", ["name"], :name => "index_media_keywords_on_name"

  create_table "media_types", :force => true do |t|
    t.string "ext", :limit => 5, :null => false
  end

  create_table "medias", :force => true do |t|
    t.string   "name",              :limit => 50,                     :null => false
    t.string   "descrip",           :limit => 75,                     :null => false
    t.string   "path",              :limit => 120,                    :null => false
    t.integer  "media_type_id",     :limit => 2,                      :null => false
    t.integer  "media_category_id",                                   :null => false
    t.boolean  "published",                        :default => false, :null => false
    t.boolean  "pending",                          :default => false, :null => false
    t.string   "assigned_to",       :limit => 50,                     :null => false
    t.text     "notes",                                               :null => false
    t.integer  "used_count",                                          :null => false
    t.datetime "date_added"
    t.string   "fla_file_name"
    t.string   "fla_content_type"
    t.integer  "fla_file_size"
    t.datetime "fla_updated_at"
    t.string   "swf_file_name"
    t.string   "swf_content_type"
    t.integer  "swf_file_size"
    t.datetime "swf_updated_at"
  end

  add_index "medias", ["name", "descrip"], :name => "name"

  create_table "news", :force => true do |t|
    t.string   "summary",                  :null => false
    t.string   "headline",   :limit => 75, :null => false
    t.text     "content",                  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
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
    t.integer  "pin",        :limit => 3,   :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at",                                   :null => false
    t.datetime "expired_at"
  end

  add_index "schools", ["name", "city"], :name => "school_index"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string  "name", :limit => 30,                    :null => false
    t.string  "abbr", :limit => 15,                    :null => false
    t.boolean "intl",               :default => false, :null => false
  end

  create_table "study_histories", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.integer  "word_list_id",    :null => false
    t.string   "study_type",      :null => false
    t.string   "user_ip_address", :null => false
    t.datetime "submitted_at",    :null => false
  end

  create_table "subscription_plans", :force => true do |t|
    t.string  "name",         :limit => 100, :null => false
    t.integer "max_teachers",                :null => false
    t.integer "cost",                        :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscription_plan_id", :null => false
    t.integer  "pin"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.datetime "expired_at",           :null => false
  end

  create_table "templates", :force => true do |t|
    t.integer  "admin",                      :default => 0, :null => false
    t.integer  "activity_id",                :default => 0, :null => false
    t.integer  "language_id",                :default => 0, :null => false
    t.integer  "user_id",                    :default => 0, :null => false
    t.string   "name",        :limit => 50,                 :null => false
    t.string   "description", :limit => 150,                :null => false
    t.text     "xml",                                       :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
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
    t.datetime "expired_at"
    t.datetime "last_login_at"
    t.integer  "login_count",                        :default => 0,     :null => false
    t.string   "last_login_ip",       :limit => 40
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
    t.integer "word_list_id",               :default => 0,  :null => false
    t.string  "keyword",      :limit => 40, :default => "", :null => false
  end

end
