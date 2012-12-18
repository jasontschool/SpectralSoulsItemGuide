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

ActiveRecord::Schema.define(:version => 20121218020039) do

  create_table "equipment", :force => true do |t|
    t.string   "name"
    t.string   "item_type"
    t.boolean  "unique_user"
    t.integer  "range"
    t.integer  "range_unique_code"
    t.integer  "height"
    t.string   "element"
    t.string   "absorb"
    t.string   "register"
    t.integer  "sell"
    t.integer  "buy"
    t.string   "invent1"
    t.string   "invent2"
    t.string   "weapon1"
    t.integer  "weapon1_level"
    t.string   "weapon2"
    t.integer  "weapon2_level"
    t.string   "weapon3"
    t.integer  "weapon3_level"
    t.string   "weapon4"
    t.integer  "weapon4_level"
    t.string   "autoskill"
    t.integer  "autoskill_slot_count"
    t.integer  "atk1"
    t.integer  "atk2"
    t.integer  "atk3"
    t.integer  "atk4"
    t.integer  "atk5"
    t.integer  "def1"
    t.integer  "def2"
    t.integer  "def3"
    t.integer  "def4"
    t.integer  "def5"
    t.integer  "hit1"
    t.integer  "hit2"
    t.integer  "hit3"
    t.integer  "hit4"
    t.integer  "hit5"
    t.integer  "avd1"
    t.integer  "avd2"
    t.integer  "avd3"
    t.integer  "avd4"
    t.integer  "avd5"
    t.integer  "mag1"
    t.integer  "mag2"
    t.integer  "mag3"
    t.integer  "mag4"
    t.integer  "mag5"
    t.integer  "str1"
    t.integer  "str2"
    t.integer  "str3"
    t.integer  "str4"
    t.integer  "str5"
    t.integer  "vit1"
    t.integer  "vit2"
    t.integer  "vit3"
    t.integer  "vit4"
    t.integer  "vit5"
    t.integer  "agl1"
    t.integer  "agl2"
    t.integer  "agl3"
    t.integer  "agl4"
    t.integer  "agl5"
    t.integer  "int1"
    t.integer  "int2"
    t.integer  "int3"
    t.integer  "int4"
    t.integer  "int5"
    t.integer  "luk1"
    t.integer  "luk2"
    t.integer  "luk3"
    t.integer  "luk4"
    t.integer  "luk5"
    t.integer  "cost2"
    t.integer  "cost3"
    t.integer  "cost4"
    t.integer  "cost5"
    t.integer  "ap1"
    t.integer  "ap2"
    t.integer  "ap3"
    t.integer  "ap4"
    t.integer  "ap5"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "equipment", ["name"], :name => "index_equipment_on_name"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "item_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "items", ["name"], :name => "index_items_on_name"

  create_table "recipes", :force => true do |t|
    t.integer  "result_id"
    t.integer  "component_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "recipes", ["component_id"], :name => "index_recipes_on_component_id"
  add_index "recipes", ["result_id"], :name => "index_recipes_on_result_id"

end
