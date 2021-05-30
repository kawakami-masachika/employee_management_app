class ExistsDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      Date.parse(record)
    rescue ArgumentError
      record.errors[:attribute] << (options[:message] || "入力された日付は存在しません")
    end
  end
end