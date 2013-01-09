module ApplicationHelper
  def prettify_date_hash(date)
    return date unless date.is_a?(Hash)
    "#{date['month']}/#{date['day']}/#{date['year']}"
  end

  def date_from_hash(date)
    return false if date.blank?
    Date.new(date["year"].to_i, date["month"].to_i, date["day"].to_i)
  end
end
