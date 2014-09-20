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

ActiveRecord::Schema.define(version: 20140920150318) do

  create_table "accounts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.integer  "organization_id"
  end

  add_index "accounts", ["organization_id"], name: "index_accounts_on_organization_id"
  add_index "accounts", ["owner_id"], name: "index_accounts_on_owner_id"

  create_table "addresses", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phone"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "addresses", ["organization_id"], name: "index_addresses_on_organization_id"

  create_table "adjustments", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adjustments", ["order_id"], name: "index_adjustments_on_order_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "dimensions", force: true do |t|
    t.integer  "height"
    t.integer  "width"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dimensions", ["image_id"], name: "index_dimensions_on_image_id"

  create_table "images", force: true do |t|
    t.string   "url"
    t.integer  "position"
    t.string   "title"
    t.string   "type"
    t.integer  "variant_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id"
  add_index "images", ["variant_id"], name: "index_images_on_variant_id"

  create_table "line_items", force: true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.float    "price"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "variant_id"
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"
  add_index "line_items", ["variant_id"], name: "index_line_items_on_variant_id"

  create_table "members", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["account_id"], name: "index_members_on_account_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "options", force: true do |t|
    t.string   "option_type"
    t.string   "option_value"
    t.integer  "variant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["variant_id"], name: "index_options_on_variant_id"

  create_table "order_totals", force: true do |t|
    t.float    "adjustment"
    t.float    "tax"
    t.float    "shipping"
    t.float    "payment"
    t.float    "total"
    t.float    "item"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_totals", ["order_id"], name: "index_order_totals_on_order_id"

  create_table "orders", force: true do |t|
    t.string   "number"
    t.string   "status"
    t.string   "channel"
    t.string   "email"
    t.string   "currency"
    t.datetime "placed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
  end

  add_index "orders", ["bill_address_id"], name: "index_orders_on_bill_address_id"
  add_index "orders", ["ship_address_id"], name: "index_orders_on_ship_address_id"

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "anual_sales"
    t.integer  "employees"
    t.string   "organization_type"
    t.string   "demographic_market"
  end

  create_table "payments", force: true do |t|
    t.integer  "number"
    t.string   "status"
    t.float    "amount"
    t.string   "payment_method"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "sku"
    t.string   "description"
    t.float    "price"
    t.float    "cost_price"
    t.date     "available_on"
    t.string   "permalink"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.string   "shipping_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products_taxons", force: true do |t|
    t.integer  "product_id"
    t.integer  "taxon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "products_taxons", ["product_id"], name: "index_products_taxons_on_product_id"
  add_index "products_taxons", ["taxon_id"], name: "index_products_taxons_on_taxon_id"

  create_table "properties", force: true do |t|
    t.string   "name"
    t.string   "presentation"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["product_id"], name: "index_properties_on_product_id"

  create_table "shipments", force: true do |t|
    t.string   "email"
    t.float    "cost"
    t.string   "status"
    t.string   "stock_location"
    t.string   "shipping_method"
    t.string   "tracking"
    t.datetime "updated_at"
    t.date     "shipped_at"
    t.integer  "variant_id"
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at"
  end

  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id"
  add_index "shipments", ["product_id"], name: "index_shipments_on_product_id"
  add_index "shipments", ["variant_id"], name: "index_shipments_on_variant_id"

  create_table "sources", force: true do |t|
    t.string   "name"
    t.integer  "month"
    t.integer  "year"
    t.string   "cc_type"
    t.integer  "last_digits"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["payment_id"], name: "index_sources_on_payment_id"

  create_table "taxonomies", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxons", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "taxonomy_id"
    t.integer  "position"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  add_index "taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "position"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "variants", force: true do |t|
    t.string   "sku"
    t.float    "price"
    t.float    "cost_price"
    t.integer  "quantity"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id"

end
