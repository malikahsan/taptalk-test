class DailyActivity < ApplicationRecord
  belongs_to :user

  before_validation :default_activity_at, on: :create

  validates :activity, presence: true
  validates_datetime :activity_at, on_or_before: lambda { DateTime.current }

  attr_accessor :year, :quarter

  def _datetime_format(scope: '')
    case scope
    when 'create'
      datetime_format(datetime: self.created_at)
    when 'update'
      datetime_format(datetime: self.updated_at)
    else
      datetime_format(datetime: self.activity_at)
    end
  end

  def self.activities_list(*args)
    args = args.first
    list = self.where(user_id: args[:user_id])
    if args[:year].present? && args[:quarter].present?
      list = list.where("extract(year from activity_at) = ? AND extract(month from activity_at) IN (?)", args[:year].to_i, QUARTERS[args[:quarter].to_i])
    elsif args[:year].present? && args[:quarter].blank?
      list = list.where("extract(year from activity_at) = ?", args[:year].to_i)
    end

    return list
  end

  private
  def default_activity_at
    self.activity_at = DateTime.current if self.activity_at.blank?
  end
end
