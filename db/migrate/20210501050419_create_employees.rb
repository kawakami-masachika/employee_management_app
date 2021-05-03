class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :employee_no, null: false, comment: "社員番号"
      t.string :name, null: false, comment: "氏名"
      t.string :name_kana, null: false, comment: "氏名カナ"
      t.integer :gender, null: false, comment: "性別"
      t.date :birth_date, null: false, comment: "生年月日"
      t.date :join_date, null: false, comment: "入社年月日"
      t.integer :employment_type, null: false, comment: "雇用形態"
      t.string :email, null: false, unique: true, comment: "メールアドレス"
      t.string :password_digest, null: false, comment: "パスワード"
      t.string :remember_token, comment: "トークン"
      t.boolean :admin, null: false, default: false, comment: "管理者フラグ"

      t.timestamps
    end
  end
end
