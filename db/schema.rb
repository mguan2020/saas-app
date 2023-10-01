#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151111030914) do

    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
  
    create_table "members", force: :cascade do |t|
      t.integer  "tenant_id"
      t.integer  "user_id"
      t.string   "first_name"
      t.string   "last_name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    add_index "members", ["tenant_id"], name: "index_members_on_tenant_id", using: :btree
    add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree
  
    create_table "sessions", force: :cascade do |t|
      t.string   "session_id", null: false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  
    add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  
    create_table "tenants", force: :cascade do |t|
      t.integer  "tenant_id"
      t.string   "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    add_index "tenants", ["name"], name: "index_tenants_on_name", using: :btree
    add_index "tenants", ["tenant_id"], name: "index_tenants_on_tenant_id", using: :btree
  
    create_table "tenants_users", id: false, force: :cascade do |t|
      t.integer "tenant_id", null: false
      t.integer "user_id",   null: false
    end
  
    add_index "tenants_users", ["tenant_id", "user_id"], name: "index_tenants_users_on_tenant_id_and_user_id", using: :btree
  
    create_table "users", force: :cascade do |t|
      t.string   "email",                        default: "",    null: false
      t.string   "encrypted_password",           default: "",    null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",                default: 0,     null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.string   "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string   "unconfirmed_email"
      t.boolean  "skip_confirm_change_password", default: false
      t.integer  "tenant_id"
      t.datetime "created_at",                                   null: false
      t.datetime "updated_at",                                   null: false
    end
  
    add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  
    add_foreign_key "members", "tenants"
    add_foreign_key "members", "users"
    add_foreign_key "tenants", "tenants"
  end