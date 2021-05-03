module CommonUtil
  extend ActiveSupport::Concern

  def create_date(date)
    Date.parse(date)
  end
end