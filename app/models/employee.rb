class Employee < ApplicationRecord
  include CommonUtil

  attr_accessor :birth_date_year,
                :birth_date_month,
                :birth_date_day,
                :join_date_year,
                :join_date_month,
                :join_date_day

  before_save :create_employee_no, if: :new_record?

  PREFIX_EMPLOYEE_NO = "ST".freeze
  SET_EMPLOYEE_NO_SQL = "select nextval('employees_id_seq')".freeze
  NAME_KANA_FORMAT = /\A[\p{katakana}]+\z/.freeze
  EMAIL_FORAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: { maximum: 50 }
  validates :name_kana, presence: true, length: { maximum: 100 }, format: {with: NAME_KANA_FORMAT}
  
  validates :gender, presence: true
  validates :employment_type, presence: true

  validates :birth_date, presence: true
  validates :join_date, presence: true
  validates :email, presence: true, if: [:birth_date_year, :birth_date_month, :birth_date_day]

  validates :email, presence: true, uniqueness: true, format: {with: EMAIL_FORAT}, length: {maximum: 256}

  # 確認用のフィールドが必要
  validates :password_digest, presence: true

  # 未来日チェック
  validate :exists_birth_date?
  validate :exists_join_date?

  # 性別
  enum gender: {
    male: 1,
    female: 2,
    other: 3
  }

  # 雇用形態
  enum employment_type: {
    fulltime_employees: 1,
    contract_worker: 2,
    freelance: 3,
    part_time_job: 4
  }

  def create_employee_no
    self.employee_no = PREFIX_EMPLOYEE_NO +
      (ActiveRecord::Base.connection.execute(SET_EMPLOYEE_NO_SQL)[0]["nextval"]
      .to_s.rjust(4,"0"))
  end

  # 日付の各パラメータを連結する
  def concat_date(param_name, year, month, day)
    if date_blank?(param_name)
      year.concat(month.rjust(2, "0"), day.rjust(2, "0"))
    else
      nil
    end
  end

  # 空チェックを行う
  def date_blank?(param_name)
    ![self.send("#{param_name}_year"), self.send("#{param_name}_month"), self.send("#{param_name}_day")].include?(nil)
  end

  def exists_birth_date?
    if birth_date.present?
      binding.pry
      tmp_date_attributes = [birth_date_year, birth_date_month, birth_date_day].map(&:to_i)
      unless Date.valid_date?(tmp_date_attributes[0], tmp_date_attributes[1], tmp_date_attributes[2])
        errors.add(:birth_date, "存在しない日付です")
      end
    end
  end

  def exists_join_date?
    if join_date.present?
      tmp_date_attributes = [join_date_year, join_date_month, join_date_day].map(&:to_i)
      unless Date.valid_date?(tmp_date_attributes[0], tmp_date_attributes[1], tmp_date_attributes[2])
        errors.add(:join_date, "存在しない日付です")
      end
    end
  end
end