class FeatureTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value > Date.today
      record.errors[:attribute] << (options[:message] || "未来の日付は登録出来ません")
    end
  end
end