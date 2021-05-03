class Employee < ApplicationRecord
  include CommonUtil

  attr_accessor :birth_date_year,
                :birth_date_month,
                :birth_date_day,
                :join_date_year,
                :join_date_month,
                :join_date_day

  before_validation :join_birth_date, :join_assign_date
  before_save :create_employee_no, if: :new_record?

  PREFIX_EMPLOYEE_NO = "ST"
  SET_EMPLOYEE_NO_SQL = "select nextval('employees_id_seq')"

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
    self.employee_no = PREFIX_EMPLOYEE_NO.concat(
      (ActiveRecord::Base.connection.execute(SET_EMPLOYEE_NO_SQL)[0]["nextval"]
      .to_s.rjust(4,"0")))
  end

  # 生年月日を結合してフォーマットを整える
  def join_birth_date
    str_birth_date = birth_date_year.concat(birth_date_month.rjust(2, "0"), birth_date_day.rjust(2, "0"))
    self.birth_date = self.create_date(str_birth_date)
  end

  # 入社年月日を結合してフォーマットを整える
  def join_assign_date
    str_join_date = join_date_year.concat(join_date_month.rjust(2, "0"), join_date_day.rjust(2, "0"))
    self.join_date = self.create_date(str_join_date)
  end
end
