# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_01_050419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "employee_no", null: false, comment: "社員番号"
    t.string "name", null: false, comment: "氏名"
    t.string "name_kana", null: false, comment: "氏名カナ"
    t.integer "gender", null: false, comment: "性別"
    t.date "birth_date", null: false, comment: "生年月日"
    t.date "join_date", null: false, comment: "入社年月日"
    t.integer "employment_type", null: false, comment: "雇用形態"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", null: false, comment: "パスワード"
    t.string "remember_token", comment: "トークン"
    t.boolean "admin", default: false, null: false, comment: "管理者フラグ"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
