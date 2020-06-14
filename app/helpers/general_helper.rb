module GeneralHelper
  def date_format(date:)
    return date.strftime("%Y-%m-%d")
  end

  def datetime_format(datetime:)
    return datetime.strftime("%Y-%m-%d %H:%M:%S")
  end

  def full_name(first_name: '', middle_name: '', last_name: '')
    return "#{first_name} #{middle_name} #{last_name}".strip.squeeze.titleize
  end
end