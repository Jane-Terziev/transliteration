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

ActiveRecord::Schema[7.1].define(version: 2024_04_01_015434) do
  create_table "transliteration_payment_request_transliterations", force: :cascade do |t|
    t.bigint "payment_request_id"
    t.string "field_name"
    t.text "original_text"
    t.text "transliterated_text"
    t.string "source_locale"
    t.string "target_locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
