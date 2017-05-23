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

ActiveRecord::Schema.define(version: 20170517102209) do

  create_table "carts", primary_key: ["user_id", "item_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "user_id",          limit: 45, null: false
    t.integer "item_id",                     null: false
    t.string  "ordered_quantity", limit: 45, null: false
    t.index ["item_id"], name: "fk_Cart_Items1_idx", using: :btree
  end

  create_table "categories", primary_key: "category_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "category_name", limit: 45, null: false
    t.index ["category_name"], name: "Category_Name_UNIQUE", unique: true, using: :btree
  end

  create_table "feedbacks", primary_key: ["user_id", "time_date"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_id",   limit: 45,  null: false
    t.datetime "time_date",             null: false
    t.string   "feedback",  limit: 300, null: false
  end

  create_table "item_properties", primary_key: ["item_id", "item_property"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "item_id",                   null: false
    t.string  "item_property",  limit: 45, null: false
    t.string  "property_value", limit: 45
  end

  create_table "items", primary_key: "item_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "item_name",       limit: 45,  null: false
    t.integer "category_id",                 null: false
    t.integer "sub_category_id",             null: false
    t.integer "quantity",                    null: false
    t.float   "price",           limit: 53
    t.string  "description",     limit: 150
    t.string  "seller_id",       limit: 45,  null: false
    t.integer "hits"
    t.string  "image",           limit: 45
    t.index ["category_id"], name: "fk_Items_Category1_idx", using: :btree
    t.index ["seller_id"], name: "fk_Items_Seller1_idx", using: :btree
    t.index ["sub_category_id"], name: "fk_Items_SubCategory1_idx", using: :btree
  end

  create_table "maketings", primary_key: "employee_id", id: :string, limit: 45, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "employee_name",   limit: 45, null: false
    t.string "password_digest", limit: 45, null: false
  end

  create_table "order_tracks", primary_key: ["order_id", "status"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "order_id",                     null: false
    t.string   "status",            limit: 10, null: false
    t.datetime "Sstatus_time_date",            null: false
  end

  create_table "orders", primary_key: ["order_id", "item_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id",                                   null: false
    t.string  "user_id",          limit: 45,                null: false
    t.integer "item_id",                                    null: false
    t.decimal "ordered_quantity",            precision: 10, null: false
    t.float   "total_price",      limit: 53,                null: false
    t.index ["item_id"], name: "fk_Orders_Items1_idx", using: :btree
    t.index ["user_id"], name: "fk_Orders_User_idx", using: :btree
  end

  create_table "sellers", primary_key: "seller_id", id: :string, limit: 45, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "organization",    limit: 45, null: false
    t.string "password_digest", limit: 45, null: false
  end

  create_table "sub_categories", primary_key: "sub_category_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "category_id",                  null: false
    t.string  "sub_category_name", limit: 45, null: false
    t.index ["category_id"], name: "fk_SubCategory_Category1_idx", using: :btree
  end

  create_table "users", primary_key: "user_id", id: :string, limit: 45, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "user_name",       limit: 45,                null: false
    t.string  "user_email",      limit: 45,                null: false
    t.string  "password_digest", limit: 45,                null: false
    t.decimal "user_phone",                 precision: 10
    t.index ["user_email"], name: "Email_UNIQUE", unique: true, using: :btree
  end

  add_foreign_key "carts", "items", primary_key: "item_id", name: "fk_Cart_Items1"
  add_foreign_key "carts", "users", primary_key: "user_id", name: "fk_Cart_User1"
  add_foreign_key "feedbacks", "users", primary_key: "user_id", name: "fk_FeedBack_User1"
  add_foreign_key "item_properties", "items", primary_key: "item_id", name: "fk_ItemProperty_Items1"
  add_foreign_key "items", "categories", primary_key: "category_id", name: "fk_Items_Category1"
  add_foreign_key "items", "sellers", primary_key: "seller_id", name: "fk_Items_Seller1"
  add_foreign_key "items", "sub_categories", primary_key: "sub_category_id", name: "fk_Items_SubCategory1"
  add_foreign_key "order_tracks", "orders", primary_key: "order_id", name: "fk_OrderTrack_Orders1"
  add_foreign_key "orders", "items", primary_key: "item_id", name: "fk_Orders_Items1"
  add_foreign_key "orders", "users", primary_key: "user_id", name: "fk_Orders_User", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sub_categories", "categories", primary_key: "category_id", name: "fk_SubCategory_Category1"
end
