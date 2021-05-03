class Admin::EmployeesController < ApplicationController

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.valid?
      @employee.save
      flash[:success] = "社員情報の登録が完了しました"
      redirect_to root_path
    else
      flash[:notice] = "入力内容を確認してください"
      render 'new'
    end
  end

  private
  def employee_params
    params.require(:employee).permit( :name,
                                      :name_kana,
                                      :gender,
                                      :birth_date_year,
                                      :birth_date_month,
                                      :birth_date_day,
                                      :join_date_year,
                                      :join_date_month,
                                      :join_date_day,
                                      :employment_type,
                                      :email,
                                      :password_digest,
                                      :admin
                                    )
  end
end
